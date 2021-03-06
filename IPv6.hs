module IPv6 (
    IPv6Address,
    makeIPV6Address,
    maybeIPv6Address,
    showIPv6Address,
    maybeCompactIPv6Address,
    showCompactIPv6Address
    ) where

import Data.Word (Word8, Word16)
import Data.Monoid ((<>))
import Data.ByteString.Lazy (ByteString, foldl)
import Data.ByteString.Builder (toLazyByteString, word16BE)
import Numeric (showIntAtBase)
import Text.ParserCombinators.Parsec (parse, count, oneOf)

data IPv6Address = IPv6Address ByteString
    deriving (Eq, Show, Ord)

base85Digits :: String
base85Digits = ['0'..'9'] ++ ['A'..'Z'] ++ ['a'..'z'] ++ "!#$%&()*+-;<=>?@^_`{|}~"

-- Smart constructor
makeIPV6Address :: Word16 -> Word16 -> Word16 -> Word16 -> Word16 -> Word16 -> Word16 -> Word16 -> IPv6Address
makeIPV6Address w0 w1 w2 w3 w4 w5 w6 w7 =
    IPv6Address (toLazyByteString (word16BE w0 <> word16BE w1 <>
                                   word16BE w2 <> word16BE w3 <>
                                   word16BE w4 <> word16BE w5 <>
                                   word16BE w6 <> word16BE w7))

-- Parse RFC 2373 textual address representation
maybeIPv6Address :: String -> Maybe IPv6Address
maybeIPv6Address = undefined

-- Show RFC 2373 textual address representation
showIPv6Address :: IPv6Address -> String
showIPv6Address = show

-- Parse RFC 1924 compact address representation
maybeCompactIPv6Address :: String -> Maybe IPv6Address
maybeCompactIPv6Address s =
    case (parse compactIPv6Address "" s) of
        (Left _) -> Nothing
        (Right base85String) -> Just (toIPv6Address base85String)
    where compactIPv6Address =
              do base85String <- count 20 (oneOf base85Digits)
                 return base85String
          toIPv6Address _ = makeIPV6Address 0 0 0 0 0 0 0 0

-- Show RFC 1924 compact address representation
showCompactIPv6Address :: IPv6Address -> String
showCompactIPv6Address (IPv6Address bs) =
    showIntAtBase 85 intToBase85Digit ipv6Integer ""
    where intToBase85Digit = (base85Digits!!)
          ipv6Integer = Data.ByteString.Lazy.foldl op 0 bs
              where op :: Integer -> Word8 -> Integer
                    op prev v = (prev * 256) + toInteger v
