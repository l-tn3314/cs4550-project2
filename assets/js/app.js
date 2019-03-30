import css from "../css/app.scss";
// bootstrap
import jQuery from "jquery";
window.jQuery = window.$ = jQuery;
import "bootstrap";
import _ from "lodash";

import root_init from "./root";

$(() => {
      let node = $('#root')[0];
      root_init(node);
});

