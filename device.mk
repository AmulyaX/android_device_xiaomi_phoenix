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

# For QSSI builds, we skip building the system image. Instead we build the
# "non-system" images (that we support).

BOARD_DYNAMIC_PARTITION_ENABLE := true
PRODUCT_SHIPPING_API_LEVEL := 29

ifeq ($(TARGET_FWK_SUPPORTS_FULL_VALUEADDS),true)
PRODUCT_BUILD_SYSTEM_IMAGE := false
else
PRODUCT_BUILD_SYSTEM_IMAGE := true
endif
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
PRODUCT_BUILD_VENDOR_IMAGE := true
PRODUCT_BUILD_PRODUCT_IMAGE := false
PRODUCT_BUILD_PRODUCT_SERVICES_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := false
PRODUCT_BUILD_CACHE_IMAGE := true
endif
PRODUCT_BUILD_RAMDISK_IMAGE := true
PRODUCT_BUILD_USERDATA_IMAGE := true

ifeq ($(SHIPPING_API_LEVEL),29)
 # f2fs utilities
 PRODUCT_PACKAGES += \
     sg_write_buffer \
     f2fs_io \
     check_f2fs

 # Userdata checkpoint
 PRODUCT_PACKAGES += \
     checkpoint_gc
endif

# privapp-permissions whitelisting (To Fix CTS :privappPermissionsMustBeEnforced)
PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=enforce

#target name, shall be used in all makefiles
MSMSTEPPE = sm6150
TARGET_DEFINES_DALVIK_HEAP := true
$(call inherit-product, device/qcom/qssi/common64.mk)

#Inherit all except heap growth limit from phone-xhdpi-2048-dalvik-heap.mk
PRODUCT_PROPERTY_OVERRIDES  += \
        dalvik.vm.heapstartsize=8m \
        dalvik.vm.heapsize=512m \
        dalvik.vm.heaptargetutilization=0.75 \
        dalvik.vm.heapminfree=512k \
        dalvik.vm.heapmaxfree=8m

TARGET_KERNEL_VERSION := 4.14
# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard
BOARD_FRP_PARTITION_NAME := frp

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules


#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

-include $(QCPATH)/common/config/qtic-config.mk


PRODUCT_BOOT_JARS += tcmiface

TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

TARGET_DISABLE_QTI_VPP := true

PRODUCT_PACKAGES += android.hardware.media.omx@1.0-impl

# Audio configuration file
-include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/msmsteppe/msmsteppe.mk

#Audio DLKM
AUDIO_DLKM := audio_apr.ko
AUDIO_DLKM += audio_snd_event.ko
AUDIO_DLKM += audio_wglink.ko
AUDIO_DLKM += audio_q6_pdr.ko
AUDIO_DLKM += audio_q6_notifier.ko
AUDIO_DLKM += audio_adsp_loader.ko
AUDIO_DLKM += audio_q6.ko
AUDIO_DLKM += audio_usf.ko
AUDIO_DLKM += audio_pinctrl_wcd.ko
AUDIO_DLKM += audio_swr.ko
AUDIO_DLKM += audio_wcd_core.ko
AUDIO_DLKM += audio_swr_ctrl.ko
AUDIO_DLKM += audio_wsa881x.ko
AUDIO_DLKM += audio_platform.ko
AUDIO_DLKM += audio_hdmi.ko
AUDIO_DLKM += audio_stub.ko
AUDIO_DLKM += audio_wcd9xxx.ko
AUDIO_DLKM += audio_mbhc.ko
AUDIO_DLKM += audio_wcd_spi.ko
AUDIO_DLKM += audio_native.ko
AUDIO_DLKM += audio_machine_talos.ko
AUDIO_DLKM += audio_wcd934x.ko
AUDIO_DLKM += audio_pinctrl_lpi.ko
AUDIO_DLKM += audio_wcd937x.ko
AUDIO_DLKM += audio_wcd937x_slave.ko
AUDIO_DLKM += audio_bolero_cdc.ko
AUDIO_DLKM += audio_wsa_macro.ko
AUDIO_DLKM += audio_va_macro.ko
AUDIO_DLKM += audio_rx_macro.ko
AUDIO_DLKM += audio_tx_macro.ko

PRODUCT_PACKAGES += $(AUDIO_DLKM)

PRODUCT_PACKAGES += fs_config_files

DEVICE_MANIFEST_FILE := $(LOCAL_PATH)/manifest.xml
DEVICE_MATRIX_FILE := device/qcom/common/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := $(LOCAL_PATH)/framework_manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    vendor/qcom/opensource/core-utils/vendor_framework_compatibility_matrix.xml

#Healthd packages
PRODUCT_PACKAGES += \
    libhealthd.msm

# Adding vendor manifest
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/manifest.xml:$(TARGET_COPY_OUT_VENDOR)/manifest.xml

#audio related module
PRODUCT_PACKAGES += libvolumelistener

PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service \
    android.hardware.broadcastradio@1.0-impl

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += $(LOCAL_PATH)/configs/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# Powerhint configuration file
PRODUCT_COPY_FILES += $(LOCAL_PATH)/powerhint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.xml

# Camera configuration file. Shared by passthrough/binderized camera HAL
PRODUCT_PACKAGES += camera.device@3.2-impl
PRODUCT_PACKAGES += camera.device@1.0-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-impl
# Enable binderized camera HAL
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-service_64

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service \

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Media Configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs_skunk.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs_skunk.xml \
    $(LOCAL_PATH)/configs/media_profiles_skunk.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_profiles_skunk.xml

# Ramdisk
PRODUCT_PACKAGES += \
    init.target.rc \
    fstab.qcom

# USB default HAL
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service

# Sensor conf files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml


# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

# system prop for opengles version
#
# 196608 is decimal for 0x30000 to report version 3
# 196609 is decimal for 0x30001 to report version 3.1
# 196610 is decimal for 0x30002 to report version 3.2
PRODUCT_PROPERTY_OVERRIDES  += \
    ro.opengles.version=196610

#vendor prop to enable advanced network scanning
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.enableadvancedscan=true

# Property to disable ZSL mode
PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1

#Enable full treble flag
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true

PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE:=true
TARGET_MOUNT_POINTS_SYMLINKS := false

PRODUCT_PROPERTY_OVERRIDES += \
			ro.crypto.volume.filenames_mode = "aes-256-cts" \
			ro.crypto.allow_encrypt_override = true
# HIDL
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/manifest_sdmmagpie.xml:$(TARGET_COPY_OUT_VENDOR)/odm/etc/vintf/manifest_365.xml \
    $(LOCAL_PATH)/manifest_sdmmagpie.xml:$(TARGET_COPY_OUT_VENDOR)/odm/etc/vintf/manifest_366.xml \
    $(LOCAL_PATH)/manifest-qva.xml:$(TARGET_COPY_OUT_ODM)/etc/vintf/manifest.xml

# Target specific Netflix custom property
PRODUCT_PROPERTY_OVERRIDES += \
    ro.netflix.bsp_rev=Q6150-17263-1
