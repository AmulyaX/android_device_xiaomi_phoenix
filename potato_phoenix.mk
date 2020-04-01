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

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from phoenix device
$(call inherit-product, device/xiaomi/phoenix/device.mk)

# Inherit from Potato vendor
$(call inherit-product, vendor/potato/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := potato_phoenix
PRODUCT_DEVICE := phoenix
PRODUCT_BRAND := Xiaomi
PRODUCT_MANUFACTURER := Xiaomi

BUILD_FINGERPRINT := POCO/phoenixin/phoenixin:10/QKQ1.190825.002/V11.0.6.0.QGHINXM:user/release-keys

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
