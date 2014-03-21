# In this string we need to use -D__SOME__ command for define which platform we use
# And C preprocessor use only code for platform, we defined
# For example if we use Texas Instruments OMAP 3430 - we should use
# EXTRA_CFLAGS += -D__PLAT_QCOMM_APQ8064__
# Else if we need for Freescale i.MX31 - we should use
# EXTRA_CFLAGS += -D__PLAT_FREESCALE_IMX31__

# I don't yet have this fully set up for the droid x yet
# This line seems to work on my X, otherwise use the line
# That's commented out.
#EXTRA_CFLAGS += -D__PLAT_TI_OMAP3430__ -Wall -march=arm
#EXTRA_CFLAGS += -mfpu=neon
#EXTRA_CFLAGS += -D__KERNEL__ -DKERNEL -DCONFIG_KEXEC -march=armv7-a -mtune=cortex-a9
#EXTRA_CFLAGS += -D__KERNEL__ -DKERNEL -DCONFIG_KEXEC 
EXTRA_CFLAGS += -D__KERNEL__ -DKERNEL -DCONFIG_KEXEC -Wall -w

# Make this match the optimisation values of the kernel you're
# loading this into. Should work without changes, but it seems to
# crash on the Nexus One and Droid Pro. If you're compiling on an 
# Evo 4g, set this value to 1 and change the EXTRA_CFLAGS value to
# something appropriate to your phone
# EXTRA_CFLAGS += -O0

ARCH		= arm
#OBJDIR		= /mnt/Android/optimusg/kexec-git/kexec-tools/objdir-arm
#target		= arm-unknown-none
#host		= arm-unknown-none

# Compiler for building kexec
#CC		= /mnt/Android/heroc/new/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-gcc
#CPP		= /mnt/Android/heroc/new/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-gcc -E

CPPFLAGS	=  -I$kernel/

obj-m += kexec_load.o
kexec_load-objs := kexec.o call_with_stack.o machine_kexec.o mmu.o sys.o core.o relocate_kernel.o \
	proc-v7.o tlb-v7.o cache-v7.o abort-ev7.o copypage-v6.o entry-common.o driver_sys.o

all:
########   Kernel stock Z1 : 3.4.0-perf-g66807d4-02450-g9a218f1
#	make -C kernel/ M=$(PWD) modules
#	make -C $(HOME)/kernel/android_kernel_sony_msm8974/ M=$(PWD) modules
	#make -C /lib/modules/3.8.0-32-generic/build M=$(PWD) modules
	#make -C /usr/src/linux-headers-3.8.0-32-generic M=$(PWD) modules
	#make -C /usr/arm-linux-gnueabi M=$(PWD) modules
	#make -C /usr/arm-linux-gnueabi/lib M=$(PWD) modules
	make -C /home/misi/xperia/kernel M=$(PWD) modules
	/home/misi/android_cm/cm10.2/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-strip --strip-unneeded *.ko

clean:
	#make -C kernel/ M=$(PWD) clean
	#make -C $(HOME)/kernel/android_kernel_sony_msm8974/ M=$(PWD) clean
	rm -f *.order
	make -C /home/misi/xperia/kernel M=$(PWD) clean
