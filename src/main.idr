module Main

import GPIO

tick_peroid_ms : IO Int
tick_peroid_ms = foreign FFI_C "#portTICK_PERIOD_MS" (IO Int)

task_delay : Int -> IO ()
task_delay delay = foreign FFI_C "vTaskDelay" (Int -> IO ()) delay

toggle_led : IO ()
toggle_led = do 
  GPIO.setLevel GPIO.pin2 GPIO.Low
  task_delay 100
  GPIO.setLevel GPIO.pin2 GPIO.High
  toggle_led

main : IO ()
main = do
  putStrLn "hello"
  GPIO.padSelect GPIO.pin2
  GPIO.setDirection GPIO.pin2 GPIO.ModeOutput
  toggle_led 

