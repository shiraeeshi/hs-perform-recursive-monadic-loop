{-# LANGUAGE  GeneralizedNewtypeDeriving #-}
module Main where

import Lib
import Control.Monad.State.Strict (StateT, get, modify, runStateT)
import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified Data.Map as Map

class DictApp m where
  dget :: String -> m (Maybe String)
  dput :: String -> String -> m ()

newtype Dict a = Dict (StateT (Map.Map String String) IO a) deriving (Functor, Applicative, Monad, MonadIO)

instance DictApp Dict where
  dget s = Dict $ Map.lookup s <$> get
  dput k v = Dict $ modify $ Map.insert k v

dictAppAction :: Dict a -> IO ()
dictAppAction (Dict dictAction) = do
  runStateT dictAction Map.empty
  return ()

main :: IO ()
main = dictAppAction loop
  where
    loop = do
      line <- liftIO $ getLine
      case words line of
        --["get", k] -> (liftIO . putStrLn . show) <$> dget k
        ["get", k] -> do
          v <- dget k
          liftIO $ putStrLn (show v)
          loop
        ["put", k, "=", v] -> do
          dput k v
          liftIO (putStrLn "")
          loop
        ["quit"] -> do
          liftIO $ putStrLn "bye"
          return ()
        l -> do
          liftIO $ putStrLn $ "echoing " ++ (unwords l)
          loop
