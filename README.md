An attempt at running idris on an [ESP32](https://en.wikipedia.org/wiki/ESP32).

I've forked the idris compiler to make a few minor changes [here](https://github.com/aktowns/Idris-dev). 

At the moment theres a working blink example for the [esp32-devkitc](https://www.espressif.com/en/products/hardware/esp32-devkitc/overview) 
in [src/main.idr](src/main.idr). which looks a little like 

```idris
import GPIO

taskDelay : Int -> IO ()
taskDelay delay = foreign FFI_C "vTaskDelay" (Int -> IO ()) delay

toggleLed : IO ()
toggleLed = do 
  GPIO.setLevel GPIO.pin2 GPIO.Low
  taskDelay 100
  GPIO.setLevel GPIO.pin2 GPIO.High
  toggleLed

main : IO ()
main = do
  putStrLn "hello"
  GPIO.padSelect GPIO.pin2
  GPIO.setDirection GPIO.pin2 GPIO.ModeOutput
  toggleLed 
```

As you can see its not very idris'y at the moment, and many things still need to be wrapped. 
Under the hood we're using [freertos](https://www.freertos.org/) from the [esp-idf](https://github.com/espressif/esp-idf). 

The above blink example will eventually blow the stack after 5 minutes or so ;)

after setting up esp-idf you can compile and flash using the usual, `putStrLn` and friends get sent to uart so 
`make monitor` works fine.

```
make
make flash
```
