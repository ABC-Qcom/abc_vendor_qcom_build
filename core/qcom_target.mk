# Target-specific configuration

# Bring in Qualcomm helper macros
include vendor/qcom/build/core/qcom_utils.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    BOARD_USES_QTI_HARDWARE := true
endif

ifeq ($(BOARD_USES_QTI_HARDWARE),true)
    B_FAMILY := msm8226 msm8610 msm8974
    B64_FAMILY := msm8992 msm8994
    BR_FAMILY := msm8909 msm8916
    UM_FAMILY := msm8937 msm8953

    ifneq ($(TARGET_USES_AOSP),true)
        TARGET_USES_QCOM_BSP := true
    endif

    BOARD_USES_ADRENO := true

    # Tell HALs that we're compiling an AOSP build with an in-line kernel
    TARGET_COMPILE_WITH_MSM_KERNEL := true

    ifeq ($(call is-board-platform-in-list, $(A_FAMILY)),true)
        # Enable legacy audio functions
        ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
            ifneq ($(filter msm8960,$(TARGET_BOARD_PLATFORM)),)
                USE_CUSTOM_AUDIO_POLICY := 1
            endif
        endif
    endif

    # Allow building audio encoders
    TARGET_USES_QCOM_MM_AUDIO := true

    # Enable color metadata for modern UM targets
    ifneq ($(filter msm8996 msm8998 sdm660,$(TARGET_BOARD_PLATFORM)),)
        TARGET_USES_COLOR_METADATA := true
    endif

    # List of targets that use master side content protection
    MASTER_SIDE_CP_TARGET_LIST := msm8996 msm8998 sdm660

    # Every qcom platform is considered a vidc target
    MSM_VIDC_TARGET_LIST := $(TARGET_BOARD_PLATFORM)
    ifeq ($(call is-board-platform-in-list, $(B_FAMILY)),true)
        QCOM_HARDWARE_VARIANT := msm8974
    else
    ifeq ($(call is-board-platform-in-list, $(B64_FAMILY)),true)
        QCOM_HARDWARE_VARIANT := msm8994
    else
    ifeq ($(call is-board-platform-in-list, $(BR_FAMILY)),true)
        QCOM_HARDWARE_VARIANT := msm8916
    else
    ifeq ($(call is-board-platform-in-list, $(UM_FAMILY)),true)
        QCOM_HARDWARE_VARIANT := msm8996
    else
        QCOM_HARDWARE_VARIANT := $(TARGET_BOARD_PLATFORM)
    endif
    endif
    endif
    endif
    endif
endif
