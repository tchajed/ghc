% -----------------------------------------------------------------------------
% $Id: PrelDynamic.lhs,v 1.5 2000/06/30 13:39:35 simonmar Exp $
%
% (c) The University of Glasgow, 1998-2000
%

The Dynamic type is used in the Exception type, so we have to have
Dynamic visible here.  The rest of the operations on Dynamics are
available in exts/Dynamic.lhs.

\begin{code}
{-# OPTIONS -fno-implicit-prelude #-}

#ifndef __HUGS__
module PrelDynamic where

import PrelBase
#endif

data Dynamic = Dynamic TypeRep Obj

data Obj = Obj  
 -- dummy type to hold the dynamically typed value.

data TypeRep
 = App TyCon   [TypeRep]
 | Fun TypeRep TypeRep
   deriving ( Eq )

-- type constructors are 
data TyCon = TyCon Int String

instance Eq TyCon where
  (TyCon t1 _) == (TyCon t2 _) = t1 == t2
\end{code}
