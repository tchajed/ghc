% -----------------------------------------------------------------------------
% $Id: PrelStable.lhs,v 1.7 2000/06/30 13:39:36 simonmar Exp $
%
% (c) The GHC Team, 1992-2000
%

\section{Module @PrelStable@}

\begin{code}
{-# OPTIONS -fno-implicit-prelude #-}

module PrelStable 
	( StablePtr(..)
	, makeStablePtr	  -- :: a -> IO (StablePtr a)    
	, deRefStablePtr  -- :: StablePtr a -> a
	, freeStablePtr   -- :: StablePtr a -> IO ()
   ) where

import PrelBase
import PrelIOBase

-----------------------------------------------------------------------------
-- Stable Pointers

data StablePtr  a = StablePtr  (StablePtr#  a)

instance CCallable   (StablePtr a)
instance CReturnable (StablePtr a)

makeStablePtr  :: a -> IO (StablePtr a)
deRefStablePtr :: StablePtr a -> IO a
foreign import "freeStablePtr" unsafe freeStablePtr :: StablePtr a -> IO ()

makeStablePtr a = IO $ \ s ->
    case makeStablePtr# a s of (# s', sp #) -> (# s', StablePtr sp #)

deRefStablePtr (StablePtr sp) = IO $ \s -> deRefStablePtr# sp s


instance Eq (StablePtr a) where 
    (StablePtr sp1) == (StablePtr sp2) =
	case eqStablePtr# sp1 sp2 of
	   0# -> False
	   _  -> True
\end{code}
