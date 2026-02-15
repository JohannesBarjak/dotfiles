# Use `mkLiteral` for string-like values that should show without quotes.
{config, ...}: let inherit (config.lib.formats.rasi) mkLiteral; in {
  "*" = {};

  window = {
    location = mkLiteral "center";
    anchor = mkLiteral "center";

    width = mkLiteral "640px";
    height = mkLiteral "480px";

    border-radius = mkLiteral "10px";
    orientation = mkLiteral "horizontal";
    spacing = mkLiteral "0";

    children = mkLiteral "[ mainbox ]";
  };

  entry = {
    placeholder = "Search here...";
  };

  prompt.enabled = false;

  mainbox = {
    children = mkLiteral "[ inputbar, message, listview ]";
    spacing = mkLiteral "0";
  };

  message = {
    padding = mkLiteral "10px";
    border = mkLiteral "0px 2px 2px 2px";
  };

  inputbar = {
    padding = mkLiteral "14px";

    border = mkLiteral "1px";
    border-radius = mkLiteral "10px 10px 0px 0px";
    children = [ "entry" ];
  };

  listview = {
    padding = mkLiteral "8px";

    border = mkLiteral "1px";
    border-radius = mkLiteral "0px 0px 10px 10px";

    dynamic = false;
  };

  element = {
    padding = mkLiteral "5px";
    vertical-align = mkLiteral "0.5";
    border-radius = mkLiteral "10px";
  };

  "element-text, element-icon" = {
    size = mkLiteral "2.5ch";

    vertical-align = mkLiteral "0.5";
    margin = mkLiteral "0 10 0 0";
  };

  button = {
    padding = mkLiteral "6px";
    horizontal-align = mkLiteral "0.5";

    border = mkLiteral "2px 0px 2px 2px";
    border-radius = mkLiteral "10px";
  };

  "button.selected.normal" = {
    border = mkLiteral "2px 0px 2px 2px";
  };
}
