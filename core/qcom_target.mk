# Target-specific configuration

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)

    qcom_flags := -DQCOM_HARDWARE
    qcom_flags += -DQCOM_BSP
    qcom_flags += -DQTI_BSP

    TARGET_USES_QCOM_BSP := true

    # Tell HALs that we're compiling an AOSP build with an in-line kernel
    TARGET_COMPILE_WITH_MSM_KERNEL := true

    ifneq ($(filter msm7x30 msm8660 msm8960,$(TARGET_BOARD_PLATFORM)),)
        # Enable legacy graphics functions
        qcom_flags += -DQCOM_BSP_LEGACY
        # Enable legacy audio functions
        ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
            qcom_flags += -DLEGACY_ALSA_AUDIO
        endif
    endif

    TARGET_GLOBAL_CFLAGS += $(qcom_flags)
    TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)
    CLANG_TARGET_GLOBAL_CFLAGS += $(qcom_flags)
    CLANG_TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)

    # Multiarch needs these too..
    2ND_TARGET_GLOBAL_CFLAGS += $(qcom_flags)
    2ND_TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)
    2ND_CLANG_TARGET_GLOBAL_CFLAGS += $(qcom_flags)
    2ND_CLANG_TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)

    ifeq ($(QCOM_HARDWARE_VARIANT),)
        ifneq ($(filter msm8610 msm8226 msm8974,$(TARGET_BOARD_PLATFORM)),)
            QCOM_HARDWARE_VARIANT := msm8974
        else
        ifneq ($(filter msm8909 msm8916,$(TARGET_BOARD_PLATFORM)),)
            QCOM_HARDWARE_VARIANT := msm8916
        else
        ifneq ($(filter msm8992 msm8994,$(TARGET_BOARD_PLATFORM)),)
            QCOM_HARDWARE_VARIANT := msm8994
        else
            QCOM_HARDWARE_VARIANT := $(TARGET_BOARD_PLATFORM)
        endif
        endif
        endif
    endif
endif
