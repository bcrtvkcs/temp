# SuSFS Upstream Fixes — All Changes to Apply

Commit audit tamamlandı. Aşağıdaki değişikliklerin tümü sırayla uygulanacak.

---

## 1. `include/linux/susfs_def.h`
**Remove `DEFAULT_UNSHARE_KSU_MNT_ID`** (artık hiçbir yerde kullanılmıyor)

```c
// REMOVE this line:
#define DEFAULT_UNSHARE_KSU_MNT_ID 400000 /* used for mounts unshared by ksu process */
```

---

## 2. `drivers/kernelsu/supercalls.c`

### 2a. `susfs_is_boot_completed_triggered` rename (~line 36)
```c
// BEFORE:
bool susfs_is_boot_completed_triggered __read_mostly = false;

// AFTER:
bool susfs_is_sdcard_android_data_decrypted __read_mostly = false;
```

### 2b. Replace `susfs_is_boot_completed_triggered = true` block (~line 130-135)
Find this block:
```c
#ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
		susfs_is_boot_completed_triggered = true;
#endif // #ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
```
Replace with:
```c
#ifdef CONFIG_KSU_SUSFS
		susfs_start_sdcard_monitor_fn();
#endif // #ifdef CONFIG_KSU_SUSFS
```

### 2c. `return 0` → `return -EINVAL` (~line 950)
Inside `ksu_handle_sys_reboot()`, at the end of `if (magic2 == SUSFS_MAGIC && current_uid().val == 0)` block:
```c
// BEFORE (last line before closing brace of SUSFS_MAGIC block):
        return 0;
    }
#endif // #ifdef CONFIG_KSU_SUSFS

// AFTER:
        return -EINVAL;
    }
#endif // #ifdef CONFIG_KSU_SUSFS
```

---

## 3. `drivers/kernelsu/app_profile.c`

### Wrap `syscall_hook_manager.h` include (~line 28)
```c
// BEFORE:
#include "syscall_hook_manager.h"

// AFTER:
#ifndef CONFIG_KSU_SUSFS
#include "syscall_hook_manager.h"
#endif // #ifndef CONFIG_KSU_SUSFS
```

---

## 4. `drivers/kernelsu/kernel_umount.c`

### Add `susfs_run_sus_path_loop()` extern declaration and call
Find `struct umount_tw {` block, add before `static void umount_tw_func`:
```c
#ifdef CONFIG_KSU_SUSFS_SUS_PATH
extern void susfs_run_sus_path_loop(void);
#endif // #ifdef CONFIG_KSU_SUSFS_SUS_PATH
```

Then find `up_read(&mount_list_lock);` inside `umount_tw_func`, add AFTER it:
```c
#ifdef CONFIG_KSU_SUSFS_SUS_PATH
    // susfs_run_sus_path_loop() runs here with ksu_cred so that it can reach all the paths
    susfs_run_sus_path_loop();
#endif // #ifdef CONFIG_KSU_SUSFS_SUS_PATH
```

---

## 5. `drivers/kernelsu/setuid_hook.c`

### 5a. Fix extern declaration (~line 57)
```c
// BEFORE:
extern void susfs_run_sus_path_loop(uid_t uid);

// AFTER:
extern void susfs_run_sus_path_loop(void);
```

### 5b. Add `ksu_cred` extern (after `susfs_zygote_sid` extern, ~line 56)
```c
extern u32 susfs_zygote_sid;
extern struct cred *ksu_cred;   // ADD THIS LINE
```

### 5c. Add new taskwork struct and functions
After `susfs_zygote_sid` / `ksu_cred` extern declarations, add:
```c
#ifdef CONFIG_KSU_SUSFS_SUS_PATH
extern void susfs_run_sus_path_loop(void);
#endif // #ifdef CONFIG_KSU_SUSFS_SUS_PATH

struct susfs_handle_setuid_tw {
    struct callback_head cb;
};

static void susfs_handle_setuid_tw_func(struct callback_head *cb)
{
    struct susfs_handle_setuid_tw *tw = container_of(cb, struct susfs_handle_setuid_tw, cb);
    const struct cred *saved = override_creds(ksu_cred);

#ifdef CONFIG_KSU_SUSFS_SUS_PATH
    susfs_run_sus_path_loop();
#endif // #ifdef CONFIG_KSU_SUSFS_SUS_PATH

    revert_creds(saved);
    kfree(tw);
}

static void ksu_handle_extra_susfs_work(void)
{
    struct susfs_handle_setuid_tw *tw = kzalloc(sizeof(*tw), GFP_ATOMIC);

    if (!tw) {
        pr_err("susfs: No enough memory\n");
        return;
    }

    tw->cb.func = susfs_handle_setuid_tw_func;

    int err = task_work_add(current, &tw->cb, TWA_RESUME);
    if (err) {
        kfree(tw);
        pr_err("susfs: Failed adding task_work 'susfs_handle_setuid_tw', err: %d\n", err);
    }
}
#endif // #ifdef CONFIG_KSU_SUSFS
```

> **NOT:** Bu blok `#ifdef CONFIG_KSU_SUSFS` içinde olmaya devam eder.
> Mevcut `susfs_run_sus_path_loop` extern declaration'ı kaldırılıp bu blok içine alınır.

### 5d. Replace direct `susfs_run_sus_path_loop(new_uid)` call (~line 157)
```c
// BEFORE:
    susfs_run_sus_path_loop(new_uid);

// AFTER:
    ksu_handle_extra_susfs_work();
```

Also remove the `susfs_reorder_mnt_id()` call if still present (this function no longer exists in our kernel).

---

## 6. `fs/proc_namespace.c`

### 6a. Three places: `>=` → `==`
Find all three occurrences of:
```c
		r->mnt_id >= DEFAULT_KSU_MNT_ID &&
```
Replace with:
```c
		r->mnt_id == DEFAULT_KSU_MNT_ID &&
```

### 6b. Three places: add `READ_ONCE`
Find all three occurrences of:
```c
	if (susfs_hide_sus_mnts_for_non_su_procs &&
```
Replace with:
```c
	if (READ_ONCE(susfs_hide_sus_mnts_for_non_su_procs) &&
```

---

## 7. `security/selinux/avc.c`

```c
// BEFORE:
	if (unlikely(sad->tsid == susfs_ksu_sid && susfs_is_avc_log_spoofing_enabled)) {

// AFTER:
	if (unlikely(sad->tsid == susfs_ksu_sid && READ_ONCE(susfs_is_avc_log_spoofing_enabled))) {
```

---

## 8. `fs/namei.c`

### Add hook in `lookup_dcache()` before `return dentry;`
```c
	return dentry;
```
Replace with:
```c
#ifdef CONFIG_KSU_SUSFS_SUS_PATH
	if (dentry && !IS_ERR(dentry) && dentry->d_inode && susfs_is_inode_sus_path(dentry->d_inode)) {
		if (d_in_lookup(dentry))
			d_lookup_done(dentry);
		dput(dentry);
		return NULL;
	}
#endif
	return dentry;
```

---

## 9. `fs/notify/fdinfo.c`

### `susfs_is_current_proc_umounted_app()` → `susfs_is_current_proc_umounted()`
```c
// BEFORE:
		if (mnt->mnt_id >= DEFAULT_KSU_MNT_ID &&
			likely(susfs_is_current_proc_umounted_app()))

// AFTER:
		if (mnt->mnt_id >= DEFAULT_KSU_MNT_ID &&
			likely(susfs_is_current_proc_umounted()))
```

### Add missing `out_path_put` and `out_kfree` labels
Find:
```c
			kfree(pathname);
			goto orig_flow;
		}
		if (kern_path(dpath, 0, &path)) {
			kfree(pathname);
			goto orig_flow;
		}
```
Replace with:
```c
			kfree(pathname);
			goto out_kfree;
		}
		if (kern_path(dpath, 0, &path)) {
			kfree(pathname);
			goto out_kfree;
		}
		if (!path.dentry->d_inode) {
			goto out_path_put;
		}
```

And find the cleanup block, replace with:
```c
			kfree(pathname);
			iput(inode);
			return;
out_path_put:
			path_put(&path);
out_kfree:
			kfree(pathname);
		}
orig_flow:
```

---

## 10. `fs/proc/fd.c`

### 10a. Add forward declaration at top (after `#include "fd.h"`)
```c
#ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
struct mount *susfs_get_non_sus_mnt_from_mnt(struct mount *orig_mnt);
#endif // #ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
```

### 10b. `susfs_is_current_proc_umounted_app()` → `susfs_is_current_proc_umounted()`
```c
// BEFORE:
	if (mnt->mnt_id >= DEFAULT_KSU_MNT_ID &&
		likely(susfs_is_current_proc_umounted_app()))

// AFTER:
	if (mnt->mnt_id >= DEFAULT_KSU_MNT_ID &&
		likely(susfs_is_current_proc_umounted()))
```

### 10c. Replace manual mnt_parent loop with `susfs_get_non_sus_mnt_from_mnt`
Find:
```c
		for (; mnt && mnt->mnt_parent && mnt != mnt->mnt_parent && mnt->mnt_id >= DEFAULT_KSU_MNT_ID; mnt = mnt->mnt_parent) { }

		seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n",
				(long long)file->f_pos, f_flags,
				mnt->mnt_id,
```
Replace with:
```c
		seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n",
				(long long)file->f_pos, f_flags,
				susfs_get_non_sus_mnt_from_mnt(mnt)->mnt_id,
```

### 10d. Add `out_path_put` and `out_kfree` labels
Find:
```c
			kfree(pathname);
			goto orig_flow;
		}
		if (kern_path(dpath, 0, &path)) {
			kfree(pathname);
			goto orig_flow;
		}
```
Replace with:
```c
			goto out_kfree;
		}
		if (kern_path(dpath, 0, &path)) {
			goto out_kfree;
		}
		if (!path.dentry->d_inode) {
			goto out_path_put;
		}
```

And the cleanup:
```c
		path_put(&path);
		kfree(pathname);
		goto bypass_orig_flow;
out_path_put:
		path_put(&path);
out_kfree:
		kfree(pathname);
	}
orig_flow:
```

---

## 11. `fs/statfs.c`

### Full rewrite of `vfs_statfs()`

Add includes at top (after `#include <linux/compat.h>`):
```c
#ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
#include <linux/susfs_def.h>
#include "mount.h"
#endif // #ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
```

Add extern after `EXPORT_SYMBOL(vfs_get_fsid);`:
```c
#ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
extern struct vfsmount *susfs_get_non_sus_vfsmnt_from_vfsmnt(struct vfsmount *vfsmnt);
#endif //#ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
```

Replace entire `vfs_statfs()` function:
```c
int vfs_statfs(const struct path *path, struct kstatfs *buf)
{
	int error;
#ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
	struct vfsmount *no_sus_vfsmnt = NULL;

	if (likely(susfs_is_current_proc_umounted() && path->mnt)) {
		no_sus_vfsmnt = susfs_get_non_sus_vfsmnt_from_vfsmnt(path->mnt);
		if (path->mnt == no_sus_vfsmnt) {
			dput(no_sus_vfsmnt->mnt_root);
			mntput(no_sus_vfsmnt);
			goto orig_flow;
		}
		error = statfs_by_dentry(no_sus_vfsmnt->mnt_root, buf);
		if (!error)
			buf->f_flags = calculate_f_flags(no_sus_vfsmnt);
		dput(no_sus_vfsmnt->mnt_root);
		mntput(no_sus_vfsmnt);
		return error;
	}
orig_flow:
	error = statfs_by_dentry(path->dentry, buf);
	if (!error)
		buf->f_flags = calculate_f_flags(path->mnt);
	return error;
#else
	error = statfs_by_dentry(path->dentry, buf);
```

> **NOT:** Mevcut `vfs_statfs`'in kapanış brace'ine kadar olan kısmı ve `#endif` doğru şekilde eklenmelidir.

---

## 12. `fs/namespace.c`

### Add two new functions at the end of file (before final `#endif /* CONFIG_SYSCTL */` or at end)

```c
#ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
/* - To retrieve the non sus mount from mount, takes no any references */
struct mount *susfs_get_non_sus_mnt_from_mnt(struct mount *orig_mnt) {
	struct mount *mnt = orig_mnt;

	lock_mount_hash();
	for (; mnt && mnt->mnt_parent && mnt != mnt->mnt_parent && mnt->mnt_id >= DEFAULT_KSU_MNT_ID; mnt = mnt->mnt_parent) { }
	unlock_mount_hash();
	return mnt;
}

/* - To retrieve the non sus vfsmount from vfsmount, takes a reference on &mnt->mnt and mnt->mnt.mnt_root */
struct vfsmount *susfs_get_non_sus_vfsmnt_from_vfsmnt(struct vfsmount *vfsmnt) {
	struct mount *mnt = real_mount(vfsmnt);

	lock_mount_hash();
	for (; mnt && mnt->mnt_parent && mnt != mnt->mnt_parent && mnt->mnt_id >= DEFAULT_KSU_MNT_ID; mnt = mnt->mnt_parent) { }
	mntget(&mnt->mnt);
	if (!mnt->mnt.mnt_root || IS_ERR(mnt->mnt.mnt_root)) {
		mntput(&mnt->mnt);
		unlock_mount_hash();
		return vfsmnt;
	}
	dget(mnt->mnt.mnt_root);
	unlock_mount_hash();
	return &mnt->mnt;
}
#endif // #ifdef CONFIG_KSU_SUSFS_SUS_MOUNT
```

---

## 13. `fs/susfs.c` — spinlock → seqlock/WRITE_ONCE/READ_ONCE

Bu en büyük değişiklik. Aşağıdaki dönüşümler:

### 13a. Add `#include <linux/seqlock.h>` at top

### 13b. `SUSFS_LOGI`/`SUSFS_LOGE` macros
```c
// BEFORE:
#define SUSFS_LOGI(fmt, ...) if (susfs_is_log_enabled) pr_info(...)
#define SUSFS_LOGE(fmt, ...) if (susfs_is_log_enabled) pr_err(...)

// AFTER:
#define SUSFS_LOGI(fmt, ...) if (READ_ONCE(susfs_is_log_enabled)) pr_info(...)
#define SUSFS_LOGE(fmt, ...) if (READ_ONCE(susfs_is_log_enabled)) pr_err(...)
```

### 13c. `sus_mount` section — remove spinlock, use WRITE_ONCE
```c
// REMOVE:
static DEFINE_SPINLOCK(susfs_spin_lock_sus_mount);

// In susfs_set_hide_sus_mnts_for_non_su_procs():
// BEFORE:
	spin_lock(&susfs_spin_lock_sus_mount);
	susfs_hide_sus_mnts_for_non_su_procs = info.enabled;
	spin_unlock(&susfs_spin_lock_sus_mount);

// AFTER:
	WRITE_ONCE(susfs_hide_sus_mnts_for_non_su_procs, info.enabled);
```

### 13d. `spoof_uname` section — replace spinlock with seqlock
```c
// REMOVE:
static DEFINE_SPINLOCK(susfs_spin_lock_set_uname);
static struct st_susfs_uname my_uname;
static void susfs_my_uname_init(void) {
	memset(&my_uname, 0, sizeof(my_uname));
}

// ADD:
static struct st_susfs_uname my_uname = {0};
static bool is_susfs_uname_set = false;
static DEFINE_SEQLOCK(susfs_uname_seqlock);
```

In `susfs_set_uname()`:
```c
// BEFORE:
	spin_lock(&susfs_spin_lock_set_uname);
	if (!strcmp(info.release, "default")) {
		strncpy(my_uname.release, utsname()->release, __NEW_UTS_LEN);
	} else {
		strncpy(my_uname.release, info.release, __NEW_UTS_LEN);
	}
	if (!strcmp(info.version, "default")) {
		strncpy(my_uname.version, utsname()->version, __NEW_UTS_LEN);
	} else {
		strncpy(my_uname.version, info.version, __NEW_UTS_LEN);
	}
	spin_unlock(&susfs_spin_lock_set_uname);

// AFTER:
	write_seqlock(&susfs_uname_seqlock);
	if (!strcmp(info.release, "default")) {
		strscpy(my_uname.release, utsname()->release, __NEW_UTS_LEN);
	} else {
		strncpy(my_uname.release, info.release, __NEW_UTS_LEN);
	}
	if (!strcmp(info.version, "default")) {
		strscpy(my_uname.version, utsname()->version, __NEW_UTS_LEN);
	} else {
		strncpy(my_uname.version, info.version, __NEW_UTS_LEN);
	}
	is_susfs_uname_set = true;
	write_sequnlock(&susfs_uname_seqlock);
```

Also add empty check before seqlock:
```c
	if (*info.release == '\0' || *info.version == '\0') {
		info.err = -EFAULT;
		goto out_copy_to_user;
	}
```

In `susfs_spoof_uname()`:
```c
// BEFORE:
	if (unlikely(my_uname.release[0] == '\0' || spin_is_locked(&susfs_spin_lock_set_uname)))
		return;
	strncpy(tmp->release, my_uname.release, __NEW_UTS_LEN);
	strncpy(tmp->version, my_uname.version, __NEW_UTS_LEN);

// AFTER:
	unsigned seq;

	do {
		seq = read_seqbegin(&susfs_uname_seqlock);
		if (is_susfs_uname_set) {
			strncpy(tmp->release, my_uname.release, __NEW_UTS_LEN);
			strncpy(tmp->version, my_uname.version, __NEW_UTS_LEN);
		}
	} while (read_seqretry(&susfs_uname_seqlock, seq));
```

### 13e. `enable_log` section
```c
// REMOVE:
static DEFINE_SPINLOCK(susfs_spin_lock_enable_log);

// In susfs_enable_log():
// BEFORE:
	spin_lock(&susfs_spin_lock_enable_log);
	susfs_is_log_enabled = info.enabled;
	spin_unlock(&susfs_spin_lock_enable_log);
	if (susfs_is_log_enabled) {

// AFTER:
	WRITE_ONCE(susfs_is_log_enabled, info.enabled);
	if (info.enabled) {
```

### 13f. `spoof_cmdline_or_bootconfig` section — replace spinlock with seqlock
```c
// REMOVE:
static DEFINE_SPINLOCK(susfs_spin_lock_set_cmdline_or_bootconfig);

// ADD:
static bool susfs_is_fake_cmdline_or_bootconfig_set = false;
static DEFINE_SEQLOCK(susfs_fake_cmdline_or_bootconfig_seqlock);
```

In `susfs_set_cmdline_or_bootconfig()`, add empty check:
```c
	if (*info->fake_cmdline_or_bootconfig == '\0') {
		info->err = -EINVAL;
		goto out_copy_to_user;
	}
```

Then:
```c
// BEFORE:
	spin_lock(&susfs_spin_lock_set_cmdline_or_bootconfig);
	strncpy(...);
	spin_unlock(&susfs_spin_lock_set_cmdline_or_bootconfig);

// AFTER:
	write_seqlock(&susfs_fake_cmdline_or_bootconfig_seqlock);
	strncpy(...);
	susfs_is_fake_cmdline_or_bootconfig_set = true;
	write_sequnlock(&susfs_fake_cmdline_or_bootconfig_seqlock);
```

Also remove `susfs_is_fake_cmdline_or_bootconfig_set = false;` from error path if present.

In `susfs_spoof_cmdline_or_bootconfig()`:
```c
// BEFORE:
	if (susfs_is_fake_cmdline_or_bootconfig_set && fake_cmdline_or_bootconfig) {
		seq_puts(m, fake_cmdline_or_bootconfig);
		return 0;
	}
	return 1;

// AFTER:
	unsigned seq;
	int err = -EINVAL;

	do {
		seq = read_seqbegin(&susfs_fake_cmdline_or_bootconfig_seqlock);
		if (susfs_is_fake_cmdline_or_bootconfig_set) {
			seq_puts(m, fake_cmdline_or_bootconfig);
			err = 0;
		}
	} while (read_seqretry(&susfs_fake_cmdline_or_bootconfig_seqlock, seq));

	return err;
```

### 13g. `avc_log_spoofing` section
```c
// REMOVE:
static DEFINE_SPINLOCK(susfs_spin_lock_set_avc_log_spoofing);

// In susfs_set_avc_log_spoofing():
// BEFORE:
	spin_lock(&susfs_spin_lock_set_avc_log_spoofing);
	susfs_is_avc_log_spoofing_enabled = info.enabled;
	spin_unlock(&susfs_spin_lock_set_avc_log_spoofing);

// AFTER:
	WRITE_ONCE(susfs_is_avc_log_spoofing_enabled, info.enabled);
```

### 13h. `susfs_start_sdcard_monitor_fn()` — WRITE_ONCE
```c
// BEFORE:
		susfs_is_sdcard_android_data_decrypted = true;

// AFTER:
		WRITE_ONCE(susfs_is_sdcard_android_data_decrypted, true);
```

### 13i. Remove `susfs_my_uname_init()` call from `susfs_init()`
```c
// REMOVE from susfs_init():
#ifdef CONFIG_KSU_SUSFS_SPOOF_UNAME
	susfs_my_uname_init();
#endif
```

---

## Uygulama Sırası

1. `susfs_def.h` → `supercalls.c` → `app_profile.c` → `kernel_umount.c` → `setuid_hook.c`
2. `proc_namespace.c` → `avc.c` → `namei.c`
3. `fdinfo.c` → `fd.c` → `statfs.c` → `namespace.c`
4. `susfs.c` (en son — en büyük değişiklik)

Her grup sonrası build yapılması önerilir.
