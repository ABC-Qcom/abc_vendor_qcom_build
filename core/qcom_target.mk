# Target-specific configuration

# Enable DirectTrack on QCOM legacy boards
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)

    TARGET_GLOBAL_CFLAGS += -DQCOM_HARDWARE
    TARGET_GLOBAL_CPPFLAGS += -DQCOM_HARDWARE

    TARGET_USES_QCOM_BSP := true
    TARGET_GLOBAL_CFLAGS += -DQCOM_BSP
    TARGET_GLOBAL_CPPFLAGS += -DQCOM_BSP

    TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

    # Enable DirectTrack for legacy targets
    ifneq ($(filter msm7x30 msm8660 msm8960,$(TARGET_BOARD_PLATFORM)),)
    ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
        TARGET_GLOBAL_CFLAGS += -DQCOM_DIRECTTRACK
        TARGET_GLOBAL_CPPFLAGS += -DQCOM_DIRECTTRACK
    endif
	# Enable legacy graphics functions
    LOCAL_GLOBAL_CFLAGS += -DQCOM_BSP_LEGACY
    LOCAL_GLOBAL_CPPFLAGS += -DQCOM_BSP_LEGACY
    endif
endif
