# Use `mkLiteral` for string-like values that should show without quotes.
{config, ...}: let inherit (config.lib.formats.rasi) mkLiteral; in {
  "*" = {
    bg0 = mkLiteral "#282828d0";
    bg1 = mkLiteral "#32302fd0";

    fg0 = mkLiteral "#eee0b7";

    fg1 = mkLiteral "#a89984d0";
    fg2 = mkLiteral "#7c6f64d0";

    yellow = mkLiteral "#d8a657d0";
    red = mkLiteral "#ea6962d0";

    yellowdark = mkLiteral "#b47109d0";
    reddark = mkLiteral "#c14a4ad0";

    foreground = mkLiteral "@fg2";
    background-color = mkLiteral "transparent";

    highlight = mkLiteral "underline bold #eee0b7";
    transparent = mkLiteral "#00000000";
  };

  window = {
    location = mkLiteral "center";
    anchor = mkLiteral "center";
    height = mkLiteral "480px";
    width = mkLiteral "640px";

    background-color = mkLiteral "@transparent";

    border-radius = mkLiteral "10px";
    spacing = mkLiteral "0";
    orientation = mkLiteral "horizontal";

    children = mkLiteral "[ mainbox ]";
  };

  mainbox = {
    children = mkLiteral "[ inputbar, message, listview ]";
    spacing = mkLiteral "0";
  };

  message = {
    padding = mkLiteral "10px";
    background-color = mkLiteral "@fg1";
    border = mkLiteral "0px 2px 2px 2px";
    border-color = mkLiteral "@bg0";
  };

  inputbar = {
    color = mkLiteral "@fg0";
    padding = mkLiteral "14px";
    background-color = mkLiteral "@bg0";

    border = mkLiteral "1px";
    border-color = mkLiteral "@bg0";
    border-radius = mkLiteral "10px 10px 0px 0px";
  };

  "entry, prompt, case-indicator" = {
    text-font = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
  };

  prompt.margin = mkLiteral "0px 1em 0em 0em";

  listview = {
    padding = mkLiteral "8px";
    background-color = mkLiteral "@bg0";

    border = mkLiteral "2px 2px 2px 2px";
    border-color = mkLiteral "@bg0";
    border-radius = mkLiteral "0px 0px 10px 10px";

    dynamic = false;
  };

  element = {
    padding = mkLiteral "5px";
    vertical-align = mkLiteral "0.5";
    border-radius = mkLiteral "10px";

    color = mkLiteral "@foreground";
    background-color = mkLiteral "@transparent";
    text-color = mkLiteral "@fg0";
  };

  "element.normal.active".background-color = mkLiteral "@yellow";
  "element.normal.urgent".background-color = mkLiteral "@reddark";

  "element.selected.normal" = {
    background-color = mkLiteral "@fg1";
    text-color = mkLiteral "@bg0";
  };

  "element.selected.active".background-color = mkLiteral "@yellowdark";
  "element.selected.urgent".background-color = mkLiteral "@red";

  "element-text, element-icon" = {
    size = mkLiteral "2.5ch";

    vertical-align = mkLiteral "0.5";
    margin = mkLiteral "0 10 0 0";

    background-color = mkLiteral "@transparent";
    text-color = mkLiteral "@fg0";
  };

  button = {
    color = mkLiteral "@foreground";

    padding = mkLiteral "6px";
    horizontal-align = mkLiteral "0.5";

    border = mkLiteral "2px 0px 2px 2px";
    border-color = mkLiteral "@foreground";
    border-radius = mkLiteral "10px";
  };

  "button.selected.normal" = {
    border = mkLiteral "2px 0px 2px 2px";
    border-color = mkLiteral "@foreground";
  };
}
