<meta name="viewport" content="width=device-width, initial-scale=1">
<style media="screen">
body {
    background: #f3f3f3;
    font-weight: lighter;
    font-family: Arial,Helvetica Neue,Helvetica,sans-serif;
}
#container {
    background: white;
    padding: 30px;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
}
h1, h2 {
    font-weight: lighter;
    text-align: center;
    line-height: 1.23em;
}
h2 {
    color: #636363;
    font-size: 1.1em;
}
.ats-logo {
    width: 200px;
    height: auto;
    padding-left: 50%;
    margin-left: -100px;
}
.form-control {
    display: block;
    width: 50%;
    margin: 1em 0;
}
label, select {
    display: block;
    clear: right;
}
label {
    font-weight: bold;
    font-size: 1em;
    color: #101010;
    line-height: 2em;
}
label.radio-label {
    font-weight: normal;
}
button {
    background: #03A9F4;
    background: -moz-linear-gradient(top, #93cede 0%, #75bdd1 41%, #49a5bf 100%);
    padding: 1em;
    font-weight: bold;
    color: white;
    border: 1px solid #4ea8c1;
    border-radius: 3px;
    font-size: 1em;
    text-align: center;
    width: 9em;
    cursor: hand;
}
textarea {
    border: 1px solid #b7b7b7;
    border-radius: 6px;
    -webkit-box-shadow: inset 0px 0px 18px 0px rgb(243, 243, 243);
    -moz-box-shadow: inset 0px 0px 18px 0px rgba(125,125,125,0.62);
    box-shadow: inset 0px 0px 18px 0px rgb(243, 243, 243);
    width: 100%;
}
.wide {
    width: 100%;
}

.question {
    border-bottom: 1px solid #eaeaea;
    margin: 1em 0;
    padding: 1em 0;
}
.radio-list {
    margin: 1em 0;
    text-align: center;
}


:hov

.cls

element.style {
}
.radio-list label {
    display: inline-block;
    font-weight: normal;
    width: 10%;
}
span.scale {
    color: #636363;
    font-style: italic;
    margin-top: 1em;
}
span.scale.poor {
    float: left;
    display: inline-block;
}
span.scale.excellent {
    float: right;
}
@media (max-width: 660px) {
    .clear-mobile {
        clear: both;
        display: block;
        width: 100%;
    }
    #container {
        padding: 30px 10px;
    }
}

.radio3 label::before {
    overflow: hidden;
    vertical-align: middle;
    text-align: center
}
.radio3 label {
    white-space: normal;
    cursor: pointer
}
.radio3.radio-inline {
    padding-top: 0;
    padding-left: 0;
    padding-right: 0;
    margin-left: 0;
    margin-right: 20px
}
.radio3 {
    position: relative;
    display: inline;
}
.radio3 input {
    position: absolute;
    left: -9999px
}
.radio3 label {
    position: relative;
    padding: 0.5em 0.7em 0em 2.3em;
    font-weight: normal;
}
.radio-list .radio3 label {
    position: relative;
    padding: 0.5em 0.7em 0em 1.1em;
}
.radio3 label::after,
.radio3 label::before {
    content: '';
    display: block;
    position: absolute;
    top: 10px;
    bottom: 10px;
    left: 0
}
.radio3 label::before {
    width: 21px;
    height: 21px;
    border: 1px solid #848484;
    -webkit-transition: background-color .2s;
    -moz-transition: background-color .2s;
    transition: background-color .2s
}
.radio3 label::after {
    width: 15px;
    height: 15px;
    border: 12px solid #FFF;
    margin: 1px;
    -webkit-transition: all 50ms;
    -moz-transition: all 50ms;
    transition: all 50ms;
    opacity: 0
}
.radio3 input:checked+label::before {
    font-family: FontAwesome;
    border-width: 1px;
    border-style: solid;
    background-color: #ef9701;
    border-color: #ef9701;
    color: #fff
}
.radio3 input:checked+label::after {
    border: 3px solid #FFF;
    opacity: 1
}
.radio3.radio-check label::after,
.radio3.radio-check.radio-light label::after {
    content: "\f00c";
    font-family: FontAwesome;
    color: #FFF;
    width: 19px;
    height: 20px;
    line-height: 20px;
    vertical-align: middle;
    text-align: center;
    border-width: 0
}
.radio3 label::after,
.radio3 label::before {
    -moz-border-radius: 20px;
    border-radius: 20px
}
.radio3.radio-check input:checked+label::after {
    border-width: 0
}
.radio3.radio-check.radio-light input:checked+label::before {
    background-color: transparent
}
.radio3.radio-check.radio-light input:checked+label::after {
    border-width: 0;
    color: #ef9701
}
.radio3.radio-sm label {
    padding: 8px 0 8px 22px
}
.radio3.radio-sm label::before {
    width: 14px;
    height: 14px;
    line-height: 14px
}
.radio3.radio-sm label::after {
    width: 12px;
    height: 12px
}
.radio3.radio-lg label {
    padding: 15px 0 15px 40px
}
.radio3.radio-lg label::before {
    width: 28px;
    height: 27px;
    line-height: 24px
}
.radio3.radio-lg label::after {
    width: 26px;
    height: 25px
}
.radio3.radio-check.radio-sm label::after {
    font-size: 9px;
    line-height: 12px;
    width: 12px
}
.radio3.radio-check.radio-lg label::after {
    font-size: 16px;
    line-height: 26px;
    width: 26px
}
.radio3.radio-primary input:checked+label::before {
    background-color: #4183d7;
    border-color: #4183d7
}
.radio3.radio-info input:checked+label::before {
    background-color: #2caef5;
    border-color: #2caef5
}
.radio3.radio-success input:checked+label::before {
    background-color: #36b846;
    border-color: #36b846
}
.radio3.radio-warning input:checked+label::before {
    background-color: #ff9c00;
    border-color: #ff9c00
}
.radio3.radio-danger input:checked+label::before {
    background-color: #e50011;
    border-color: #e50011
}
.radio3.radio-primary.radio-light input:checked+label::before {
    background-color: transparent
}
.radio3.radio-primary.radio-light input:checked+label::after {
    color: #4183d7
}
.radio3.radio-info.radio-light input:checked+label::before {
    background-color: transparent
}
.radio3.radio-info.radio-light input:checked+label::after {
    color: #2caef5
}
.radio3.radio-success.radio-light input:checked+label::before {
    background-color: transparent
}
.radio3.radio-success.radio-light input:checked+label::after {
    color: #36b846
}
.radio3.radio-warning.radio-light input:checked+label::before {
    background-color: transparent
}
.radio3.radio-warning.radio-light input:checked+label::after {
    color: #ff9c00
}
.radio3.radio-danger.radio-light input:checked+label::before {
    background-color: transparent
}
.radio3.radio-danger.radio-light input:checked+label::after {
    color: #e50011
}
span.reqd {
    color: red;
    font-size: 1.1em;
}
</style>
{{ get_title() }}
{{ content() }}
