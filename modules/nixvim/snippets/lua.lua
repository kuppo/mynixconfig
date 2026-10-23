return {
  s("autoenable", {
    t("auto_enable = "),
    c(1, {
      t("true"),
      t("false"),
    }),
    t(","),
  }),
  s("lzep", {
    t({ "return {", "\t\"" }),
    i(1, "plugin"),
    t({ "\",", "\t" }),
    i(2, "auto_enable"),
    t({ "", "}" }),
  }),
  s("trig", {
    t("Text: "),
    i(1),
    t({ "", "Copy of above text: " }),
    d(2, function(args)
      return sn(ni, { i(1, args[1]) })
    end, { 1 }),
  }),
}
