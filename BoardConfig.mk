#
# Copyright (C) 2020 Potato Open Sauce Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_VENDOR := xiaomi
DEVICE_PATH := device/xiaomi/phoenix

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sm6150
TARGET_NO_BOOTLOADER := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include

#Generate DTBO image
BOARD_KERNEL_SEPARATED_DTBO := true

TARGET_KERNEL_APPEND_DTB := true

# Set Header version for bootimage
ifneq ($(strip $(TARGET_KERNEL_APPEND_DTB)),true)
#Enable DTB in bootimage and Set Header version
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOTIMG_HEADER_VERSION := 2
else
BOARD_BOOTIMG_HEADER_VERSION := 1
endif
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

# Non-A/B section. Define cache and recovery partition variables.
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
# Enable System As Root even for non-A/B
ifeq ($(BOARD_AVB_ENABLE), true)
   BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
   BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
   BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
   BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
endif

TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/recovery.fstab

### Dynamic partition Handling
ifneq ($(strip $(BOARD_DYNAMIC_PARTITION_ENABLE)),true)
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
    ifeq ($(ENABLE_AB), true)
        TARGET_NO_RECOVERY := true
        BOARD_USES_RECOVERY_AS_BOOT := true
    else
        BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x04000000
        ifeq ($(BOARD_KERNEL_SEPARATED_DTBO),true)
            # Enable DTBO for recovery image
            BOARD_INCLUDE_RECOVERY_DTBO := true
        endif
    endif
else
# Define the Dynamic Partition sizes and groups.
        BOARD_SUPER_PARTITION_SIZE := 6442450944
    ifeq ($(BOARD_KERNEL_SEPARATED_DTBO),true)
        # Enable DTBO for recovery image
        BOARD_INCLUDE_RECOVERY_DTBO := true
    endif
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 6438256640
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := vendor
BOARD_EXT4_SHARE_DUP_BLOCKS := true
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x06000000
endif
### Dynamic partition Handling

ifeq ($(SHIPPING_API_LEVEL),29)
  BOARD_SYSTEMSDK_VERSIONS:=29
else
  BOARD_SYSTEMSDK_VERSIONS:=28
endif

#Enable split vendor image
ENABLE_VENDOR_IMAGE := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_DTBOIMG_PARTITION_SIZE := 0x0800000
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

TARGET_KERNEL_VERSION := 4.14
BOARD_PREBUILT_DTBOIMAGE := out/target/product/sm6150/prebuilt_dtbo.img
BOARD_VENDOR_KERNEL_MODULES := \
    $(KERNEL_MODULES_OUT)/audio_apr.ko \
    $(KERNEL_MODULES_OUT)/audio_snd_event.ko \
    $(KERNEL_MODULES_OUT)/audio_wglink.ko \
    $(KERNEL_MODULES_OUT)/audio_q6_pdr.ko \
    $(KERNEL_MODULES_OUT)/audio_q6_notifier.ko \
    $(KERNEL_MODULES_OUT)/audio_adsp_loader.ko \
    $(KERNEL_MODULES_OUT)/audio_q6.ko \
    $(KERNEL_MODULES_OUT)/audio_usf.ko \
    $(KERNEL_MODULES_OUT)/audio_pinctrl_wcd.ko \
    $(KERNEL_MODULES_OUT)/audio_pinctrl_lpi.ko \
    $(KERNEL_MODULES_OUT)/audio_swr.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd_core.ko \
    $(KERNEL_MODULES_OUT)/audio_swr_ctrl.ko \
    $(KERNEL_MODULES_OUT)/audio_wsa881x.ko \
    $(KERNEL_MODULES_OUT)/audio_platform.ko \
    $(KERNEL_MODULES_OUT)/audio_hdmi.ko \
    $(KERNEL_MODULES_OUT)/audio_stub.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd9xxx.ko \
    $(KERNEL_MODULES_OUT)/audio_mbhc.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd934x.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd937x.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd937x_slave.ko \
    $(KERNEL_MODULES_OUT)/audio_bolero_cdc.ko \
    $(KERNEL_MODULES_OUT)/audio_wsa_macro.ko \
    $(KERNEL_MODULES_OUT)/audio_va_macro.ko \
    $(KERNEL_MODULES_OUT)/audio_rx_macro.ko \
    $(KERNEL_MODULES_OUT)/audio_tx_macro.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd_spi.ko \
    $(KERNEL_MODULES_OUT)/audio_native.ko \
    $(KERNEL_MODULES_OUT)/audio_machine_talos.ko \
    $(KERNEL_MODULES_OUT)/wil6210.ko \
    $(KERNEL_MODULES_OUT)/msm_11ad_proxy.ko \
    $(KERNEL_MODULES_OUT)/mpq-adapter.ko \
    $(KERNEL_MODULES_OUT)/mpq-dmx-hw-plugin.ko

BOARD_VENDOR_KERNEL_MODULES += $(shell ls $(KERNEL_MODULES_OUT)/*.ko)
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_QCOM_BSP := false
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=1 androidboot.usbcontroller=a600000.dwc3 earlycon=msm_geni_serial,0x880000 loop.max_part=7 cgroup.memory=nokmem,nosocket

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := $(shell pwd)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-
TARGET_USES_UNCOMPRESSED_KERNEL := false

BOARD_USES_GENERIC_AUDIO := true
BOARD_QTI_CAMERA_32BIT_ONLY := true
TARGET_NO_RPC := true

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_INIT_VENDOR_LIB := libinit_msm

TARGET_COMPILE_WITH_MSM_KERNEL := true

#Enable PD locater/notifier
TARGET_PD_SERVICE_ENABLED := true

#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true

TARGET_HW_DISK_ENCRYPTION := true
TARGET_HW_DISK_ENCRYPTION_PERF := true

# Enable dex pre-opt to speed up initial boot
ifeq ($(HOST_OS),linux)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
      ifneq ($(TARGET_BUILD_VARIANT),user)
        # Retain classes.dex in APK's for non-user builds
        DEX_PREOPT_DEFAULT := nostripping
      endif
    endif
endif


# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

# Enable sensor Version V_2
USE_SENSOR_HAL_VER := 2.0

#Add non-hlos files to ota packages
ADD_RADIO_FILES := true

#Enable LM
TARGET_USES_LM := true

# Enable QG user space
PMIC_QG_SUPPORT := true

ifeq ($(ENABLE_VENDOR_IMAGE), false)
$(error "Vendor Image is mandatory !!")
endif

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
include device/qcom/wlan/talos/BoardConfigWlan.mk
endif

BOARD_VNDK_VERSION:= current
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_PHONY_TARGETS := true

#################################################################################
# This is the End of BoardConfig.mk file.
# Now, Pickup other split Board.mk files:
#################################################################################
# TODO: Relocate the system Board.mk files pickup into qssi lunch, once it is up.
-include vendor/qcom/defs/board-defs/system/*.mk
-include vendor/qcom/defs/board-defs/vendor/*.mk
#################################################################################
