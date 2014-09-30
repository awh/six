module IPv6 (
	IPv6Address (..),
	maybeIPv6Address,
	maybeCompactIPv6Address,
	showIPv6Address,
	showCompactIPv6Address
	) where

import Data.Word

data IPv6Address = IPv6Address Word16 Word16 Word16 Word16 Word16 Word16 Word16 Word16
	deriving (Eq, Show, Ord)

-- Parse RFC 2373 textual address representation
maybeIPv6Address :: String -> Maybe IPv6Address
maybeIPv6Address = undefined

-- Parse RFC 1924 compact address representation
maybeCompactIPv6Address :: String -> Maybe IPv6Address
maybeCompactIPv6Address = undefined

-- Show RFC 2373 textual address representation
showIPv6Address :: IPv6Address -> String
showIPv6Address = show

-- Show RFC 1924 compact address representation
showCompactIPv6Address :: IPv6Address -> String
showCompactIPv6Address = show
