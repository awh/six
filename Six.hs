module Main where

import IPv6

main :: IO ()
main = putStrLn (showCompactIPv6Address (makeIPV6Address 0x1080 0x0 0x0 0x0 0x8 0x800 0x200C 0x417A))
