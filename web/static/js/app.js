// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "deps/phoenix_html/web/static/js/phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
// import "node_modules/micromarkdown/micromarkdown"
var mmd = require("micromarkdown");
console.log(mmd.parse("**ok**"));
console.log(mmd.parse("**OK**"));

// var areas = document.getElementsByTagName("textarea");
var areas = $("textarea");
console.log(areas);

class MarkdownParser {
    constructor(textarea) {
        this.textarea = $(textarea);
    }

    parse() {
        var previewDiv = this.textarea.siblings(".preview");
        var val = this.textarea.val();
        previewDiv.html(mmd.parse(val));
    }
}

for (var i = 0; i < areas.length; i++) {
    var parser = new MarkdownParser(areas[i]);
    parser.parse()
}

$("textarea").on("change keyup blur", function() {
    var parser = new MarkdownParser(this);
    parser.parse();
});
