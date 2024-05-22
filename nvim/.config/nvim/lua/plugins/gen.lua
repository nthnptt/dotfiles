return {
  "David-Kunz/gen.nvim",
  config = function()
    require("gen").prompts["Builder_function_parameters"] = {
      prompt = "Add parameters of object created in this function as parameters of this function. \nExample :\n<BEFORE>\npublic function cow(): Cow {\n  return new Cow(\n    name: 'cow',\n    weight: 128,\n    color: CowColor:WHITE,\n    farm: new Farm('my farm'),\n  )\n}\n</BEFORE>\n<EXPECTED>\npublic function cow(\n    string $name = 'cow',\n    int $weight = 128,\n    Color $color = CowColor:WHITE,\n    ?Farm $farm = null,\n): Cow {\n  return new Cow(\n    name: $name,\n    weight: $weight,\n    color: $color,\n    farm: farm ?? new Farm('my farm'),\n  )\n}\n</EXPECTED>\n Code: $text Expected:",
      replace = true,
    }
  end,
}
