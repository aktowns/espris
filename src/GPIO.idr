module GPIO 

import Data.Fin

%include C "def.h"
%include C "driver/gpio.h"

interface FFIVal a b where
  toFFI : a -> IO b

esp_ok : IO Int
esp_ok = foreign FFI_C "#ESP_OK" (IO Int)

esp_fail : IO Int
esp_fail = foreign FFI_C "#ESP_FAIL" (IO Int)

esp_err_no_mem : IO Int
esp_err_no_mem = foreign FFI_C "#ESP_ERR_NO_MEM" (IO Int)

esp_err_invalid_arg : IO Int
esp_err_invalid_arg = foreign FFI_C "#ESP_ERR_INVALID_ARG" (IO Int)

esp_err_invalid_state : IO Int
esp_err_invalid_state = foreign FFI_C "#ESP_ERR_INVALID_STATE" (IO Int)

esp_err_invalid_size : IO Int
esp_err_invalid_size = foreign FFI_C "#ESP_ERR_INVALID_SIZE" (IO Int)

esp_err_not_found : IO Int
esp_err_not_found = foreign FFI_C "#ESP_ERR_NOT_FOUND" (IO Int)

esp_err_not_supported : IO Int
esp_err_not_supported = foreign FFI_C "#ESP_ERR_NOT_SUPPORTED" (IO Int)

esp_err_timeout : IO Int
esp_err_timeout = foreign FFI_C "#ESP_ERR_TIMEOUT" (IO Int)

esp_err_invalid_response : IO Int
esp_err_invalid_response = foreign FFI_C "#ESP_ERR_INVALID_RESPONSE" (IO Int)

esp_err_invalid_crc : IO Int
esp_err_invalid_crc = foreign FFI_C "#ESP_ERR_INVALID_CRC" (IO Int)

esp_err_invalid_version : IO Int
esp_err_invalid_version = foreign FFI_C "#ESP_ERR_INVALID_VERSION" (IO Int)

esp_err_invalid_mac : IO Int
esp_err_invalid_mac = foreign FFI_C "#ESP_ERR_INVALID_MAC" (IO Int)

public export
data ESPErr = EspOk 
            | EspFail 
            | EspErrNoMem
            | EspErrInvalidArg
            | EspErrInvalidState
            | EspErrInvalidSize
            | EspErrNotFound
            | EspErrNotSupported
            | EspErrTimeout
            | EspErrInvalidResponse
            | EspErrInvalidCrc
            | EspErrInvalidVersion
            | EspErrInvalidMac
            | EspErrUnknown Int

implementation FFIVal ESPErr Int where
  toFFI EspOk                 = esp_ok
  toFFI EspFail               = esp_fail
  toFFI EspErrNoMem           = esp_err_no_mem
  toFFI EspErrInvalidArg      = esp_err_invalid_arg
  toFFI EspErrInvalidState    = esp_err_invalid_state
  toFFI EspErrInvalidSize     = esp_err_invalid_size
  toFFI EspErrNotFound        = esp_err_not_found
  toFFI EspErrNotSupported    = esp_err_not_supported
  toFFI EspErrTimeout         = esp_err_timeout
  toFFI EspErrInvalidResponse = esp_err_invalid_response
  toFFI EspErrInvalidCrc      = esp_err_invalid_crc
  toFFI EspErrInvalidVersion  = esp_err_invalid_version
  toFFI EspErrInvalidMac      = esp_err_invalid_mac
  toFFI (EspErrUnknown x)     = pure x

-- is there a cleaner way to do this? from what i read 
-- idris doesn't have pattern guards and 'with' wont work?
espErrFromFFI : Int -> IO ESPErr
espErrFromFFI x = do
  espOk <- esp_ok
  espFail <- esp_fail
  espErrNoMem <- esp_err_no_mem
  espErrInvalidArg <- esp_err_invalid_arg
  espErrInvalidState <- esp_err_invalid_state
  espErrInvalidSize <- esp_err_invalid_size
  espErrNotFound <- esp_err_not_found
  espErrNotSupported <- esp_err_not_supported
  espErrTimeout <- esp_err_timeout
  espErrInvalidResponse <- esp_err_invalid_response
  espErrInvalidCrc <- esp_err_invalid_crc
  espErrInvalidVersion <- esp_err_invalid_version
  espErrInvalidMac <- esp_err_invalid_mac
  pure $
    if      x == espOk                 then EspOk 
    else if x == espFail               then EspFail
    else if x == espErrNoMem           then EspErrNoMem
    else if x == espErrInvalidArg      then EspErrInvalidArg
    else if x == espErrInvalidState    then EspErrInvalidState
    else if x == espErrInvalidSize     then EspErrInvalidSize
    else if x == espErrNotFound        then EspErrNotFound
    else if x == espErrNotSupported    then EspErrNotSupported
    else if x == espErrTimeout         then EspErrTimeout
    else if x == espErrInvalidResponse then EspErrInvalidResponse
    else if x == espErrInvalidCrc      then EspErrInvalidCrc
    else if x == espErrInvalidVersion  then EspErrInvalidVersion
    else if x == espErrInvalidMac      then EspErrInvalidMac
    else                                    EspErrUnknown x

gpio_intr_disable : IO Int
gpio_intr_disable = foreign FFI_C "#GPIO_INTR_DISABLE" (IO Int)

gpio_intr_posedge : IO Int
gpio_intr_posedge = foreign FFI_C "#GPIO_INTR_POSEDGE" (IO Int)

gpio_intr_negedge : IO Int
gpio_intr_negedge = foreign FFI_C "#GPIO_INTR_NEGEDGE" (IO Int)

gpio_intr_anyedge : IO Int
gpio_intr_anyedge = foreign FFI_C "#GPIO_INTR_ANYEDGE" (IO Int)

gpio_intr_low_level : IO Int
gpio_intr_low_level = foreign FFI_C "#GPIO_INTR_LOW_LEVEL" (IO Int)

gpio_intr_high_level : IO Int
gpio_intr_high_level = foreign FFI_C "#GPIO_INTR_HIGH_LEVEL" (IO Int)

gpio_intr_max : IO Int
gpio_intr_max = foreign FFI_C "#GPIO_INTR_MAX" (IO Int)

public export
data GPIOIntr =
  ||| Disable GPIO interrupt
  IntrDisable |
  ||| GPIO interrupt type : rising edge
  IntrPosEdge |
  ||| GPIO interrupt type : falling edge
  IntrNegEdge |
  ||| GPIO interrupt type : both rising and falling edge
  IntrAnyEdge |
  ||| GPIO interrupt type : input low level trigger
  IntrLowLevel | 
  ||| GPIO interrupt type : input high level trigger
  IntrHighLevel

implementation FFIVal GPIOIntr Int where
  toFFI IntrDisable = gpio_intr_disable
  toFFI IntrPosEdge = gpio_intr_posedge
  toFFI IntrNegEdge = gpio_intr_negedge
  toFFI IntrAnyEdge = gpio_intr_anyedge
  toFFI IntrLowLevel = gpio_intr_low_level
  toFFI IntrHighLevel = gpio_intr_high_level

--

gpio_mode_disable : IO Int
gpio_mode_disable = foreign FFI_C "#GPIO_MODE_DISABLE" (IO Int)

gpio_mode_input : IO Int
gpio_mode_input = foreign FFI_C "#GPIO_MODE_INPUT" (IO Int)

gpio_mode_output : IO Int
gpio_mode_output = foreign FFI_C "#GPIO_MODE_OUTPUT" (IO Int)

gpio_mode_output_od : IO Int 
gpio_mode_output_od = foreign FFI_C "#GPIO_MODE_OUTPUT_OD" (IO Int)

gpio_mode_input_output_od : IO Int 
gpio_mode_input_output_od = foreign FFI_C "#GPIO_MODE_INPUT_OUTPUT_OD" (IO Int) 

gpio_mode_input_output : IO Int 
gpio_mode_input_output = foreign FFI_C "#GPIO_MODE_INPUT_OUTPUT" (IO Int)

public export
data GPIOMode = 
  ||| GPIO mode : disable input and output
  ModeDisable | 
  ||| GPIO mode : input only
  ModeInput | 
  ||| GPIO mode : output only mode
  ModeOutput | 
  ||| GPIO mode : output only with open-drain mode
  ModeOutputOD | 
  ||| GPIO mode : output and input with open-drain mode
  ModeInputOutputOD | 
  ||| GPIO mode : output and input mode
  ModeInputOutput

implementation FFIVal GPIOMode Int where 
  toFFI ModeDisable       = gpio_mode_disable
  toFFI ModeInput         = gpio_mode_input 
  toFFI ModeOutput        = gpio_mode_output 
  toFFI ModeOutputOD      = gpio_mode_output_od 
  toFFI ModeInputOutputOD = gpio_mode_input_output_od 
  toFFI ModeInputOutput   = gpio_mode_input_output

--

gpio_pullup_disable : IO Int 
gpio_pullup_disable = foreign FFI_C "#GPIO_PULLUP_DISABLE" (IO Int)

gpio_pullup_enable : IO Int 
gpio_pullup_enable = foreign FFI_C "#GPIO_PULLUP_ENABLE" (IO Int)

public export 
data GPIOPullup = 
  ||| Enable GPIO pull-up resistor
  PullupEnable | 
  ||| Disable GPIO pull-up resistor
  PullupDisable

implementation FFIVal GPIOPullup Int where
  toFFI PullupEnable  = gpio_pullup_enable
  toFFI PullupDisable = gpio_pullup_disable 

--

gpio_pullup_only : IO Int
gpio_pullup_only = foreign FFI_C "#GPIO_PULLUP_ONLY" (IO Int)

gpio_pulldown_only : IO Int
gpio_pulldown_only = foreign FFI_C "#GPIO_PULLDOWN_ONLY" (IO Int)

gpio_pullup_pulldown : IO Int
gpio_pullup_pulldown = foreign FFI_C "#GPIO_PULLUP_PULLDOWN" (IO Int)

gpio_floating : IO Int
gpio_floating = foreign FFI_C "#GPIO_FLOATING" (IO Int)

data GPIOPullMode = 
  ||| Pad pull up
  PullupOnly |
  ||| Pad pull down
  PulldownOnly |
  ||| Pad pull up + pull down
  PullupPulldown |
  ||| Pad floating
  Floating

implementation FFIVal GPIOPullMode Int where
  toFFI PullupOnly = gpio_pullup_only
  toFFI PulldownOnly = gpio_pulldown_only
  toFFI PullupPulldown = gpio_pullup_pulldown 
  toFFI Floating = gpio_floating

--

gpio_drive_cap_0 : IO Int
gpio_drive_cap_0 = foreign FFI_C "#GPIO_DRIVE_CAP_0" (IO Int)

gpio_drive_cap_1 : IO Int
gpio_drive_cap_1 = foreign FFI_C "#GPIO_DRIVE_CAP_1" (IO Int)

gpio_drive_cap_2 : IO Int
gpio_drive_cap_2 = foreign FFI_C "#GPIO_DRIVE_CAP_2" (IO Int)

gpio_drive_cap_default : IO Int
gpio_drive_cap_default = foreign FFI_C "#GPIO_DRIVE_CAP_DEFAULT" (IO Int)

gpio_drive_cap_3 : IO Int
gpio_drive_cap_3 = foreign FFI_C "#GPIO_DRIVE_CAP_3" (IO Int)

data DriveCap = 
  ||| Pad drive capability: weak
  DriveCap0 |
  ||| Pad drive capability: stronger
  DriveCap1 |
  ||| Pad drive capability: default value
  DriveCap2 |
  ||| Pad drive capability: strongest
  DriveCap3 | 
  ||| Pad drive capability: default value
  DriveCapDefault

implementation FFIVal DriveCap Int where
  toFFI DriveCap0 = gpio_drive_cap_0
  toFFI DriveCap1 = gpio_drive_cap_1
  toFFI DriveCap2 = gpio_drive_cap_2
  toFFI DriveCap3 = gpio_drive_cap_3
  toFFI DriveCapDefault= gpio_drive_cap_default

--

gpio_pulldown_disable : IO Int 
gpio_pulldown_disable = foreign FFI_C "#GPIO_PULLDOWN_DISABLE" (IO Int)

gpio_pulldown_enable : IO Int 
gpio_pulldown_enable = foreign FFI_C "#GPIO_PULLDOWN_ENABLE" (IO Int)

public export 
data GPIOPulldown = 
  ||| Disable GPIO pull-down resistor
  PulldownDisable |
  ||| Enable GPIO pull-down resistor
  PulldownEnable

implementation FFIVal GPIOPulldown Int where
  toFFI PulldownEnable  = gpio_pulldown_enable
  toFFI PulldownDisable = gpio_pulldown_disable 

--

set_intr_type : Int -> Int -> IO Int
set_intr_type gpio intr_type = 
  foreign FFI_C "gpio_set_intr_type" (Int -> Int -> IO Int) gpio intr_type

intr_enable : Int -> IO Int
intr_enable gpio = 
  foreign FFI_C "gpio_intr_enable" (Int -> IO Int) gpio

intr_disable : Int -> IO Int
intr_disable gpio = 
  foreign FFI_C "gpio_intr_disable" (Int -> IO Int) gpio

set_level : Int -> Int -> IO Int
set_level gpio level = 
  foreign FFI_C "gpio_set_level" (Int -> Int -> IO Int) gpio level

get_level : Int -> IO Int
get_level gpio = 
  foreign FFI_C "gpio_get_level" (Int -> IO Int) gpio

set_direction : Int -> Int -> IO Int
set_direction gpio direction = 
  foreign FFI_C "gpio_set_direction" (Int -> Int -> IO Int) gpio direction

--gpio_set_pull_mode : Int -> IO ()
--gpio_set_pull_mode gpio

gpio_pad_select_gpio : Int -> IO ()
gpio_pad_select_gpio pin = foreign FFI_C "gpio_pad_select_gpio" (Int -> IO()) pin

public export
data Pin = MkPin Int

public export
pin0 : Pin
pin0 = MkPin 0

public export
pin1 : Pin
pin1 = MkPin 1

public export
pin2 : Pin
pin2 = MkPin 2

public export 
data Level = High | Low

implementation FFIVal Level Int where
  toFFI High = pure 1
  toFFI Low  = pure 0

||| Select pad as a gpio function from IOMUX.
export
padSelect : Pin -> IO ()
padSelect (MkPin n) = gpio_pad_select_gpio n
 
||| Configure GPIO direction,such as output_only,input_only,output_and_input
export
setDirection : Pin -> GPIOMode -> IO ESPErr
setDirection (MkPin n) mode = toFFI mode >>= set_direction n >>= espErrFromFFI

||| GPIO set output level. 
export 
setLevel : Pin -> Level -> IO ESPErr
setLevel (MkPin n) level = toFFI level >>= set_level n >>= espErrFromFFI

