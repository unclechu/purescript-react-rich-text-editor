-- See https://github.com/sstur/react-rte
module Bindings.ReactRichTextEditor
     ( Props
     , EditorValue
     , EditorValueFormat (..)
     , richTextEditor
     , richTextEditorDefaultProps
     , createEmptyValue
     , createValueFromString
     , valueToString
     ) where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn1)

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Nullable (Nullable, toNullable)
import Data.Maybe (Maybe (..))

import React (ReactClass)


foreign import data EditorValue :: Type

type Props rootStyle editorStyle toolbarStyle =
  { className        :: Nullable String -- className?: string;
  , toolbarClassName :: Nullable String -- toolbarClassName?: string;
  , editorClassName  :: Nullable String -- editorClassName?: string;
  , value            :: EditorValue -- value: EditorValue;
  , onChange         :: Nullable (EffectFn1 EditorValue Unit)
                     -- onChange?: ChangeHandler;
                     -- type ChangeHandler = (value: EditorValue) => any;
  , placeholder      :: Nullable String -- placeholder?: string;
  -- customStyleMap?: {[style: string]: {[key: string]: any}};
  -- handleReturn?: (event: Object) => boolean;
  -- customControls?: Array<CustomControl>;
  , readOnly         :: Nullable Boolean -- readOnly?: boolean;
  , disabled         :: Nullable Boolean
                        -- disabled?: boolean; // Alias of readOnly
  -- toolbarConfig?: ToolbarConfig;
  -- blockStyleFn?: (block: ContentBlock) => ?string;
  , autoFocus        :: Nullable Boolean -- autoFocus?: boolean;
  -- keyBindingFn?: (event: Object) => ?string;
  , rootStyle        :: Nullable (Record rootStyle) -- rootStyle?: Object;
  , editorStyle      :: Nullable (Record editorStyle) -- editorStyle?: Object;
  , toolbarStyle     :: Nullable (Record toolbarStyle) -- toolbarStyle?: Object;
  }

richTextEditorDefaultProps :: EditorValue -> Props () () ()
richTextEditorDefaultProps value =
  { className        : toNullable Nothing
  , toolbarClassName : toNullable Nothing
  , editorClassName  : toNullable Nothing
  , value
  , onChange         : toNullable Nothing
  , placeholder      : toNullable Nothing
  -- customStyleMap?: {[style: string]: {[key: string]: any}};
  -- handleReturn?: (event: Object) => boolean;
  -- customControls?: Array<CustomControl>;
  , readOnly         : toNullable Nothing
  , disabled         : toNullable Nothing
  -- toolbarConfig?: ToolbarConfig;
  -- blockStyleFn?: (block: ContentBlock) => ?string;
  , autoFocus        : toNullable Nothing
  -- keyBindingFn?: (event: Object) => ?string;
  , rootStyle        : toNullable Nothing
  , editorStyle      : toNullable Nothing
  , toolbarStyle     : toNullable Nothing
  }


foreign import richTextEditor
  :: forall rootStyle editorStyle toolbarStyle
   . ReactClass (Props rootStyle editorStyle toolbarStyle)

foreign import createEmptyValue :: Effect EditorValue

foreign import createValueFromStringRaw
  :: String -> String -> Effect EditorValue

createValueFromString :: String -> EditorValueFormat -> Effect EditorValue
createValueFromString markup = createValueFromStringRaw markup <<< rawFormat

foreign import valueToStringRaw :: EditorValue -> String -> String

valueToString :: EditorValue -> EditorValueFormat -> String
valueToString value = valueToStringRaw value <<< rawFormat

data EditorValueFormat = HTML | Markdown | RAW
derive instance eqEditorValueFormat :: Eq EditorValueFormat
derive instance genericEditorValueFormat :: Generic EditorValueFormat _
instance showEditorValueFormat :: Show EditorValueFormat where
  show = genericShow

rawFormat :: EditorValueFormat -> String
rawFormat HTML     = "html"
rawFormat Markdown = "markdown"
rawFormat RAW      = "raw"
