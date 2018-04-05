module Main

--data PinState = HI | LO
--data PinMode = INPUT | OUTPUT PinState
--data Pin = Pin Num PinMode

-- pinWrite : Pin (n : Nat) (OUTPUT LO)
-- pinRead  : Pin (n : Nat) INPUT
-- pinMode  : (m : PinState) -> Pin (n : Nat) PinMode (OUTPUT (not m)) -> Pin n (OUTPUT m)

do_pin_mode : Int -> Int -> IO ()
do_pin_mode pin mode = foreign FFI_C "pin_mode" (Int -> Int -> IO ()) pin mode

main : IO () 
main = putStrLn "hello"
