-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Generics.Instances
-- Copyright   :  (c) The University of Glasgow, CWI 2001--2004
-- License     :  BSD-style (see the LICENSE file)
-- 
-- Maintainer  :  generics@haskell.org
-- Stability   :  experimental
-- Portability :  non-portable (uses Data.Data)
--
-- \"Scrap your boilerplate\" --- Generic programming in Haskell 
-- See <http://www.cs.vu.nl/boilerplate/>. The present module
-- contains thirteen 'Data' instances which are considered dubious (either
-- because the types are abstract or just not meant to be traversed).
-- Instances in this module might change or disappear in future releases
-- of this package. 
--
-- For more information, please visit the new
-- SYB wiki: <http://www.cs.uu.nl/wiki/bin/view/GenericProgramming/SYB>.
--
-- (This module does not export anything. It really just defines instances.)
--
-----------------------------------------------------------------------------

{-# OPTIONS_GHC -fno-warn-orphans #-}
module Data.Generics.Instances () where

------------------------------------------------------------------------------

#ifdef __HADDOCK__
import Prelude
#endif

import Data.Data
import Data.Typeable

#ifdef __GLASGOW_HASKELL__
#if __GLASGOW_HASKELL__ >= 611
import GHC.IO                -- So we can give Data instance for IO
import GHC.IO.Handle         -- So we can give Data instance for Handle
import GHC.MVar              -- So we can give Data instance for MVar
import GHC.Conc              -- So we can give Data instance for TVar
import GHC.IORef
#else
import GHC.IOBase            -- So we can give Data instance for IO, Handle
import GHC.Conc              -- So we can give Data instance for MVar & Co.
#endif
import GHC.Stable            -- So we can give Data instance for StablePtr
import GHC.ST                -- So we can give Data instance for ST
import GHC.MVar              -- So we can give Data instance for MVar
import GHC.Conc              -- So we can give Data instance for TVar
import GHC.IORef
#else
# ifdef __HUGS__
import Hugs.Prelude( Ratio(..) )
# endif
import System.IO
import Foreign.Ptr
import Foreign.ForeignPtr
import Foreign.StablePtr
import Control.Monad.ST
import Control.Concurrent
import Data.IORef
#endif

#include "Typeable.h"


------------------------------------------------------------------------------
--
--      Instances of the Data class for Prelude-like types.
--      We define top-level definitions for representations.
--
------------------------------------------------------------------------------


------------------------------------------------------------------------------
-- Instances of abstract datatypes (6)
------------------------------------------------------------------------------

instance Data TypeRep where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "Data.Typeable.TypeRep"


------------------------------------------------------------------------------

instance Data TyCon where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "Data.Typeable.TyCon"


------------------------------------------------------------------------------

INSTANCE_TYPEABLE0(DataType,dataTypeTc,"DataType")

instance Data DataType where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "Data.Generics.Basics.DataType"


------------------------------------------------------------------------------

instance Data Handle where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.IOBase.Handle"


------------------------------------------------------------------------------

instance Typeable a => Data (StablePtr a) where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.Stable.StablePtr"


------------------------------------------------------------------------------

#ifdef __GLASGOW_HASKELL__
instance Data ThreadId where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.Conc.ThreadId"
#endif


------------------------------------------------------------------------------
-- Dubious instances (7)
------------------------------------------------------------------------------

#ifdef __GLASGOW_HASKELL__
instance Typeable a => Data (TVar a) where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.Conc.TVar"
#endif


------------------------------------------------------------------------------

instance Typeable a => Data (MVar a) where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.Conc.MVar"


------------------------------------------------------------------------------

#ifdef __GLASGOW_HASKELL__
instance Typeable a => Data (STM a) where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.Conc.STM"
#endif


------------------------------------------------------------------------------

instance (Typeable s, Typeable a) => Data (ST s a) where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.ST.ST"


------------------------------------------------------------------------------

instance Typeable a => Data (IORef a) where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.IOBase.IORef"


------------------------------------------------------------------------------

instance Typeable a => Data (IO a) where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "GHC.IOBase.IO"

------------------------------------------------------------------------------

--
-- A last resort for functions
--

instance (Data a, Data b) => Data (a -> b) where
  toConstr _   = error "toConstr"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNoRepType "Prelude.(->)"
  dataCast2 f  = gcast2 f

