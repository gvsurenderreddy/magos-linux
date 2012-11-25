#!/bin/bash
CPATH=$PWD
cd usr/src/fglrx-*
patch -p1 <<EOF
--- a/firegl_public.c	2012-06-15 18:30:13.483762070 +0200
+++ b/firegl_public.c	2012-06-17 17:47:36.543041869 +0200
@@ -2106,6 +2106,12 @@
     }
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 5, 0)
+# define NO_DO_MMAP
+# define do_mmap(a,b,c,d,e,f) vm_mmap(a, b, c, d, e, f)
+# define do_munmap(a,b,c) vm_munmap(b, c)
+#endif
+
 unsigned long ATI_API_CALL KCL_MEM_AllocLinearAddrInterval(
                                         KCL_IO_FILE_Handle file,
                                         unsigned long addr,
@@ -2117,10 +2123,13 @@
 
     flags = MAP_SHARED;
     prot  = PROT_READ|PROT_WRITE;
-
+#ifdef NO_DO_MMAP
+    vaddr = (void *) vm_mmap(file, 0, len, prot, flags, pgoff);
+#else
     down_write(&current->mm->mmap_sem);
     vaddr = (void *) do_mmap(file, 0, len, prot, flags, pgoff);
     up_write(&current->mm->mmap_sem);
+#endif
     if (IS_ERR(vaddr))
        return 0;
     else
@@ -2131,7 +2140,9 @@
 {
     int retcode = 0;
 
+#ifndef NO_DO_MMAP
     down_write(&current->mm->mmap_sem);
+#endif
 #ifdef FGL_LINUX_RHEL_MUNMAP_API
     retcode = do_munmap(current->mm,
                         addr,
@@ -2142,7 +2153,9 @@
                         addr,
                         len);
 #endif                        
+#ifndef NO_DO_MMAP
     up_write(&current->mm->mmap_sem);
+#endif
     return retcode;
 }
 
EOF
cd $CPATH
