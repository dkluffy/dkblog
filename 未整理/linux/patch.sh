When there is a security fix available for a particular software, we typically do a binary upgrade using the package management tools like yum or apt-get.

But, there might be situation where you have installed a software by compiling it from the source code.

In those situation, how do you apply the security fix to the software?

The answer is to download the security patch and apply it to the original source code and re-compile the software.

This tutorial explains how to create a patch file using diff, and apply it using patch command.

A patch file is a text file which contains the differences between two versions of the same file (or same source-tree). Patch file is created by using diff command.

1. Create a Patch File using diff

To understand this, let us create a small C program named hello.c

#include <stdio.h> 

int main() {
printf("Hello World\n");
}
Now, copy the hello.c to hello_new.c

$ cp hello.c hello_new.c
Edit the hello_new.c as shown below to make some small changes:

#include <stdio.h>

int main(int argc, char *argv[]) {
printf("Hello World\n");
return 0;
}
Finally, create the patch file using diff command as shown below:

$ diff -u hello.c hello_new.c > hello.patch
The above command will create a patch file named “hello.patch”.

--- hello.c     2014-10-07 18:17:49.000000000 +0530
+++ hello_new.c 2014-10-07 18:17:54.000000000 +0530
@@ -1,5 +1,6 @@
 #include <stdio.h>
 
-int main() {
+int main(int argc, char *argv[]) {
        printf("Hello World\n");
+       return 0;
 }
2. Apply Patch File using Patch Command

The “patch” command takes a patch file as input and apply the differences to one or more original file(s), producing patched versions.

patch -p[num] < patchfile
patch [options] originalfile patchfile 
Use the patch command as shown below to apply the hello.patch to the original hello.c source code.

$ patch < hello.patch
patching file hello.c
The hello.patch file contains the name of the file to be patched. Once the file is patched, both hello.c and hello_new.c will have the content.

3. Create a Patch From a Source Tree

The above example was so simple that it works only with one file. We will see how to create and apply patch for a complete source tree by taking “openvpn” source code as example.

I’ve downloaded 2 version of openvpn, openvpn-2.3.2 and openvpn-2.3.4.

tar -xvzf openvpn-2.3.2.tar.gz

tar -xvzf openvpn-2.3.4.tar.gz
Now we will create the patch using the following command.

diff -Naur /usr/src/openvpn-2.3.2 /usr/src/openvpn-2.3.4 > openvpn.patch
The above command will operate recursively and find the differences, and place those differences in the patch file.

4. Apply Patch File to a Source Code Tree

The following patch commands can be used to apply the patch to source tree.

# patch -p3 < /root/openvpn.patch
patching file openvpn-2.3.2/aclocal.m4
patching file openvpn-2.3.2/build/Makefile.in
patching file openvpn-2.3.2/build/msvc/Makefile.in
...
Please note that we are executing the command from /usr/src/. The patch file contains all the filenames in absolute path format( from root ). So when we execute from /usr/src, without the “-p” option, it will not work properly.

-p3 tells the patch command to skip 3 leading slashes from the filenames present in the patch file. In our case, the filename in patch file is “/usr/src/openvpn-2.3.2/aclocal.m4″, since you have given “-p3″, 3 leading slashes, i.e. until /usr/src/ is ignored.

5. Take a Backup before Applying the Patch using -b

You can take a backup of the original file before applying the patch command using the -b option as shown below.

$ patch -b < hello.patch
patching file hello.c
Now you will have a file name “hello.c.orig”, which is the backup of the original hello.c.

You can also use -V to decide the backup filename format as shown below. Now you will have a file name “hello.c.~1~”.

$ patch -b -V numbered < hello.patch
patching file hello.c
6. Validate the Patch without Applying (Dry-run Patch File)

You can dry run the patch command to see if you are getting any errors, without patching the file using –dry-run option as shown below.

$ patch --dry-run < hello.patch
patching file hello.c
You can see that hello.c is not modified at all.

7. Reverse a Patch that is Already Applied (Undo a Patch)

You can use the -R option to reverse a patch which is applied already.

$ patch < hello.patch
patching file hello.c

$ ls -l hello.c
-rw-r--r-- 1 lakshmanan users  94 2014-10-07 20:05 hello.c

$ patch -R < hello.patch
patching file hello.c

$ ls -l hello.c
-rw-r--r-- 1 lakshmanan users  62 2014-10-07 20:04 hello.c
You can notice from the filesize, that the patch, which is applied already is reversed when we used the -R option.
