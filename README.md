# purescript-react-rich-text-editor

[PureScript][purescript] FFI bindings for ["react-rte"][rte] package.

It's work in progress, not published on [pursuit][pursuit] yet,
but it's working, I have used it in production.
For now you can dirty copy-paste it or use as [git-submodule][submodule].

## Requirements

- [purescript-prelude][purescript-prelude]
- [purescript-eff][purescript-eff]
- [purescript-generics][purescript-generics]
- [purescript-nullable][purescript-nullable]
- [purescript-maybe][purescript-maybe]
- [purescript-react][purescript-react]

## Usage example

Keep in mind that this example requires [purescript-react-spaces][purescript-react-spaces].

```purescript
value <- createValueFromString "some initial text" Markdown

-- …

onChange value = do
  log $ valueToString value Markdown
  -- …

-- …

richTextEditor ^ (richTextEditorDefaultProps value)
  { placeholder = toNullable $ Just "Type text here"
  , onChange    = toNullable $ Just $ handle onChange
  }
```

## Author

[Viacheslav Lotsmanov](https://github.com/unclechu)

## License

[MIT](LICENSE)

[purescript]: http://www.purescript.org
[pursuit]: https://pursuit.purescript.org
[rte]: https://github.com/sstur/react-rte
[submodule]: https://www.git-scm.com/docs/gitsubmodules

[purescript-prelude]: https://pursuit.purescript.org/packages/purescript-prelude/3.1.0
[purescript-eff]: https://pursuit.purescript.org/packages/purescript-eff/3.1.0
[purescript-generics]: https://pursuit.purescript.org/packages/purescript-generics/4.0.0
[purescript-maybe]: https://pursuit.purescript.org/packages/purescript-maybe/3.0.0
[purescript-nullable]: https://pursuit.purescript.org/packages/purescript-nullable/3.0.0
[purescript-dom]: https://pursuit.purescript.org/packages/purescript-dom/4.15.0
[purescript-react]: https://pursuit.purescript.org/packages/purescript-react/5.1.0

[purescript-react-spaces]: https://pursuit.purescript.org/packages/purescript-react-spaces/1.0.1
