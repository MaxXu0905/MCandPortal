if (!window.af || typeof af !== "function") {
    var af = function(window) {
        "use strict";
        var nundefined, document = window.document, emptyArray = [], slice = emptyArray.slice, classCache = {}, eventHandlers = [], _eventID = 1, jsonPHandlers = [], _jsonPID = 1, fragmentRE = /<(\w+)[^>]*>/, classSelectorRE = /^\.([\w-]+)$/, tagSelectorRE = /^[\w-]+$/, _attrCache = {}, _propCache = {}, cssNumber = {
            columncount: true,
            fontweight: true,
            lineheight: true,
            "column-count": true,
            "font-weight": true,
            "line-height": true,
            opacity: true,
            orphans: true,
            widows: true,
            zIndex: true,
            "z-index": true,
            zoom: true
        }, isWin8 = typeof MSApp === "object";
        function _addPx(prop, val) {
            return typeof val === "number" && !cssNumber[prop.toLowerCase()] ? val + "px" : val;
        }
        function _insertFragments(afm, container, insert) {
            var frag = document.createDocumentFragment();
            if (insert) {
                for (var j = afm.length - 1; j >= 0; j--) {
                    frag.insertBefore(afm[j], frag.firstChild);
                }
                container.insertBefore(frag, container.firstChild);
            } else {
                for (var k = 0; k < afm.length; k++) frag.appendChild(afm[k]);
                container.appendChild(frag);
            }
            frag = null;
        }
        function classRE(name) {
            return name in classCache ? classCache[name] : classCache[name] = new RegExp("(^|\\s)" + name + "(\\s|$)");
        }
        function unique(arr) {
            for (var i = 0; i < arr.length; i++) {
                if (arr.indexOf(arr[i]) !== i) {
                    arr.splice(i, 1);
                    i--;
                }
            }
            return arr;
        }
        function siblings(nodes, element) {
            var elems = [];
            if (nodes == nundefined) return elems;
            for (;nodes; nodes = nodes.nextSibling) {
                if (nodes.nodeType === 1 && nodes !== element) {
                    elems.push(nodes);
                }
            }
            return elems;
        }
        var $afm = function(toSelect, what) {
            this.length = 0;
            if (!toSelect) {
                return this;
            } else if (toSelect instanceof $afm && what == nundefined) {
                return toSelect;
            } else if (af.isFunction(toSelect)) {
                return af(document).ready(toSelect);
            } else if (af.isArray(toSelect) && toSelect.length != nundefined) {
                for (var i = 0; i < toSelect.length; i++) this[this.length++] = toSelect[i];
                return this;
            } else if (af.isObject(toSelect) && af.isObject(what)) {
                if (toSelect.length == nundefined) {
                    if (toSelect.parentNode == what) this[this.length++] = toSelect;
                } else {
                    for (var j = 0; j < toSelect.length; j++) if (toSelect[j].parentNode == what) this[this.length++] = toSelect[j];
                }
                return this;
            } else if (af.isObject(toSelect) && what == nundefined) {
                this[this.length++] = toSelect;
                return this;
            } else if (what !== nundefined) {
                if (what instanceof $afm) {
                    return what.find(toSelect);
                }
            } else {
                what = document;
            }
            return this.selector(toSelect, what);
        };
        var $ = function(selector, what) {
            return new $afm(selector, what);
        };
        function _selectorAll(selector, what) {
            try {
                return what.querySelectorAll(selector);
            } catch (e) {
                return [];
            }
        }
        function _selector(selector, what) {
            selector = selector.trim();
            if (selector[0] === "#" && selector.indexOf(".") === -1 && selector.indexOf(",") === -1 && selector.indexOf(" ") === -1 && selector.indexOf(">") === -1) {
                if (what === document) _shimNodes(what.getElementById(selector.replace("#", "")), this); else _shimNodes(_selectorAll(selector, what), this);
            } else if (selector[0] === "<" && selector[selector.length - 1] === ">" || selector.indexOf("<") !== -1 && selector.indexOf(">") !== -1) {
                var tmp = document.createElement("div");
                if (isWin8) {
                    MSApp.execUnsafeLocalFunction(function() {
                        tmp.innerHTML = selector.trim();
                    });
                } else tmp.innerHTML = selector.trim();
                _shimNodes(tmp.childNodes, this);
            } else {
                _shimNodes(_selectorAll(selector, what), this);
            }
            return this;
        }
        function _shimNodes(nodes, obj) {
            if (!nodes) return;
            if (nodes.nodeType) {
                obj[obj.length++] = nodes;
                return;
            }
            for (var i = 0, iz = nodes.length; i < iz; i++) obj[obj.length++] = nodes[i];
        }
        $.is$ = function(obj) {
            return obj instanceof $afm;
        };
        $.each = function(elements, callback) {
            var i, key;
            if ($.isArray(elements)) {
                for (i = 0; i < elements.length; i++) {
                    if (callback(i, elements[i]) === false) return elements;
                }
            } else if ($.isObject(elements)) {
                for (key in elements) {
                    if (!elements.hasOwnProperty(key) || key === "length") continue;
                    if (callback(key, elements[key]) === false) return elements;
                }
            }
            return elements;
        };
        $.extend = function(target) {
            if (target == nundefined) target = this;
            if (arguments.length === 1) {
                for (var key in target) this[key] = target[key];
                return this;
            } else {
                slice.call(arguments, 1).forEach(function(source) {
                    for (var key in source) target[key] = source[key];
                });
            }
            return target;
        };
        $.isArray = function(obj) {
            return obj instanceof Array && obj.push != nundefined;
        };
        $.isFunction = function(obj) {
            return typeof obj === "function" && !(obj instanceof RegExp);
        };
        $.isObject = function(obj) {
            return typeof obj === "object" && obj !== null;
        };
        $.fn = $afm.prototype = {
            namespace: "appframework",
            constructor: $afm,
            forEach: emptyArray.forEach,
            reduce: emptyArray.reduce,
            push: emptyArray.push,
            indexOf: emptyArray.indexOf,
            concat: emptyArray.concat,
            selector: _selector,
            oldElement: undefined,
            slice: emptyArray.slice,
            length: 0,
            setupOld: function(params) {
                if (params == nundefined) return $();
                params.oldElement = this;
                return params;
            },
            each: function(callback) {
                this.forEach(function(el, idx) {
                    callback.call(el, idx, el);
                });
                return this;
            },
            ready: function(callback) {
                if (document.readyState === "complete" || document.readyState === "loaded" || !$.os.ie && document.readyState === "interactive") callback(); else document.addEventListener("DOMContentLoaded", callback, false);
                return this;
            },
            find: function(sel) {
                if (this.length === 0) return this;
                var elems = [];
                var tmpElems;
                for (var i = 0; i < this.length; i++) {
                    tmpElems = $(sel, this[i]);
                    for (var j = 0; j < tmpElems.length; j++) {
                        elems.push(tmpElems[j]);
                    }
                }
                return $(unique(elems));
            },
            html: function(html, cleanup) {
                var msFix = function() {
                    item.innerHTML = html;
                };
                if (this.length === 0) return this;
                if (html === nundefined) return this[0].innerHTML;
                for (var i = 0; i < this.length; i++) {
                    if (cleanup !== false) $.cleanUpContent(this[i], false, true);
                    if (isWin8) {
                        var item = this[i];
                        MSApp.execUnsafeLocalFunction(msFix);
                    } else this[i].innerHTML = html;
                }
                return this;
            },
            text: function(text) {
                if (this.length === 0) return this;
                if (text === nundefined) return this[0].textContent;
                for (var i = 0; i < this.length; i++) {
                    this[i].textContent = text;
                }
                return this;
            },
            css: function(attribute, value, obj) {
                var toAct = obj != nundefined ? obj : this[0];
                if (this.length === 0) return this;
                if (value == nundefined && typeof attribute === "string") {
                    var styles = window.getComputedStyle(toAct);
                    return toAct.style[attribute] ? toAct.style[attribute] : window.getComputedStyle(toAct)[attribute];
                }
                for (var i = 0; i < this.length; i++) {
                    if ($.isObject(attribute)) {
                        for (var j in attribute) {
                            this[i].style[j] = _addPx(j, attribute[j]);
                        }
                    } else {
                        this[i].style[attribute] = _addPx(attribute, value);
                    }
                }
                return this;
            },
            vendorCss: function(attribute, value, obj) {
                return this.css($.feat.cssPrefix + attribute, value, obj);
            },
            cssTranslate: function(val) {
                return this.vendorCss("Transform", "translate" + $.feat.cssTransformStart + val + $.feat.cssTransformEnd);
            },
            computedStyle: function(val) {
                if (this.length === 0 || val == nundefined) return;
                return window.getComputedStyle(this[0], "")[val];
            },
            empty: function() {
                for (var i = 0; i < this.length; i++) {
                    $.cleanUpContent(this[i], false, true);
                    this[i].textContent = "";
                }
                return this;
            },
            hide: function() {
                if (this.length === 0) return this;
                for (var i = 0; i < this.length; i++) {
                    if (this.css("display", null, this[i]) !== "none") {
                        this[i].setAttribute("afmOldStyle", this.css("display", null, this[i]));
                        this[i].style.display = "none";
                    }
                }
                return this;
            },
            show: function() {
                if (this.length === 0) return this;
                for (var i = 0; i < this.length; i++) {
                    if (this.css("display", null, this[i]) === "none") {
                        this[i].style.display = this[i].getAttribute("afmOldStyle") ? this[i].getAttribute("afmOldStyle") : "block";
                        this[i].removeAttribute("afmOldStyle");
                    }
                }
                return this;
            },
            toggle: function(show) {
                if (this.length === 0) return this;
                var show2 = show === true;
                for (var i = 0; i < this.length; i++) {
                    if (this.css("display", null, this[i]) !== "none" && (show == nundefined || show2 === false)) {
                        this[i].setAttribute("afmOldStyle", this.css("display", null, this[i]));
                        this[i].style.display = "none";
                    } else if (this.css("display", null, this[i]) === "none" && (show == nundefined || show2 === true)) {
                        this[i].style.display = this[i].getAttribute("afmOldStyle") ? this[i].getAttribute("afmOldStyle") : "block";
                        this[i].removeAttribute("afmOldStyle");
                    }
                }
                return this;
            },
            val: function(value) {
                if (this.length === 0) return value === nundefined ? undefined : this;
                if (value == nundefined) return this[0].value;
                for (var i = 0; i < this.length; i++) {
                    this[i].value = value;
                }
                return this;
            },
            attr: function(attr, value) {
                if (this.length === 0) return value === nundefined ? undefined : this;
                if (value === nundefined && !$.isObject(attr)) {
                    var val = this[0].afmCacheId && _attrCache[this[0].afmCacheId] && _attrCache[this[0].afmCacheId][attr] ? _attrCache[this[0].afmCacheId][attr] : this[0].getAttribute(attr);
                    return val;
                }
                for (var i = 0; i < this.length; i++) {
                    if ($.isObject(attr)) {
                        for (var key in attr) {
                            $(this[i]).attr(key, attr[key]);
                        }
                    } else if ($.isArray(value) || $.isObject(value) || $.isFunction(value)) {
                        if (!this[i].afmCacheId) this[i].afmCacheId = $.uuid();
                        if (!_attrCache[this[i].afmCacheId]) _attrCache[this[i].afmCacheId] = {};
                        _attrCache[this[i].afmCacheId][attr] = value;
                    } else if (value === null) {
                        this[i].removeAttribute(attr);
                        if (this[i].afmCacheId && _attrCache[this[i].afmCacheId][attr]) delete _attrCache[this[i].afmCacheId][attr];
                    } else {
                        this[i].setAttribute(attr, value);
                        if (this[i].afmCacheId && _attrCache[this[i].afmCacheId][attr]) delete _attrCache[this[i].afmCacheId][attr];
                    }
                }
                return this;
            },
            removeAttr: function(attr) {
                var removeFixer = function(param) {
                    that[i].removeAttribute(param);
                    if (that[i].afmCacheId && _attrCache[that[i].afmCacheId]) delete _attrCache[that[i].afmCacheId][attr];
                };
                var that = this;
                for (var i = 0; i < this.length; i++) {
                    attr.split(/\s+/g).forEach(removeFixer);
                }
                return this;
            },
            prop: function(prop, value) {
                if (this.length === 0) return value === nundefined ? undefined : this;
                if (value === nundefined && !$.isObject(prop)) {
                    var res;
                    var val = this[0].afmCacheId && _propCache[this[0].afmCacheId] && _propCache[this[0].afmCacheId][prop] ? _propCache[this[0].afmCacheId][prop] : !(res = this[0][prop]) && prop in this[0] ? this[0][prop] : res;
                    return val;
                }
                for (var i = 0; i < this.length; i++) {
                    if ($.isObject(prop)) {
                        for (var key in prop) {
                            $(this[i]).prop(key, prop[key]);
                        }
                    } else if ($.isArray(value) || $.isObject(value) || $.isFunction(value)) {
                        if (!this[i].afmCacheId) this[i].afmCacheId = $.uuid();
                        if (!_propCache[this[i].afmCacheId]) _propCache[this[i].afmCacheId] = {};
                        _propCache[this[i].afmCacheId][prop] = value;
                    } else if (value === null && value !== undefined) {
                        $(this[i]).removeProp(prop);
                    } else {
                        $(this[i]).removeProp(prop);
                        this[i][prop] = value;
                    }
                }
                return this;
            },
            removeProp: function(prop) {
                var removePropFn = function(param) {
                    if (that[i][param]) that[i][param] = undefined;
                    if (that[i].afmCacheId && _propCache[that[i].afmCacheId]) {
                        delete _propCache[that[i].afmCacheId][prop];
                    }
                };
                var that = this;
                for (var i = 0; i < this.length; i++) {
                    prop.split(/\s+/g).forEach(removePropFn);
                }
                return this;
            },
            remove: function(selector) {
                var elems = $(this).filter(selector);
                if (elems == nundefined) return this;
                for (var i = 0; i < elems.length; i++) {
                    $.cleanUpContent(elems[i], true, true);
                    if (elems[i] && elems[i].parentNode) {
                        elems[i].parentNode.removeChild(elems[i]);
                    }
                }
                return this;
            },
            addClass: function(name) {
                var addClassLoop = function(cname) {
                    if (!that.hasClass(cname, that[i])) classList.push(cname);
                };
                if (name == nundefined) return this;
                for (var i = 0; i < this.length; i++) {
                    var cls = this[i].className;
                    var classList = [];
                    var that = this;
                    name.split(/\s+/g).forEach(addClassLoop);
                    this[i].className += (cls ? " " : "") + classList.join(" ");
                    this[i].className = this[i].className.trim();
                }
                return this;
            },
            removeClass: function(name) {
                if (name == nundefined) return this;
                var removeClassLoop = function(cname) {
                    classList = classList.replace(classRE(cname), " ");
                };
                for (var i = 0; i < this.length; i++) {
                    if (name == nundefined) {
                        this[i].className = "";
                        return this;
                    }
                    var classList = this[i].className;
                    if (typeof this[i].className === "object") {
                        classList = " ";
                    }
                    name.split(/\s+/g).forEach(removeClassLoop);
                    if (classList.length > 0) this[i].className = classList.trim(); else this[i].className = "";
                }
                return this;
            },
            toggleClass: function(name, state) {
                if (name == nundefined) return this;
                for (var i = 0; i < this.length; i++) {
                    if (typeof state !== "boolean") {
                        state = this.hasClass(name, this[i]);
                    }
                    $(this[i])[state ? "removeClass" : "addClass"](name);
                }
                return this;
            },
            append: function(element, content, insert) {
                if (element && element.length != nundefined && element.length === 0) return this;
                if ($.isArray(element) || $.isObject(element)) element = $(element);
                var i, node;
                if (content) $(this).add(content);
                for (i = 0; i < this.length; i++) {
                    if (element.length && typeof element !== "string") {
                        element = $(element);
                        _insertFragments(element, this[i], insert);
                    } else {
                        var obj = fragmentRE.test(element) ? $(element) : undefined;
                        if (obj == nundefined || obj.length === 0) {
                            obj = document.createTextNode(element);
                        }
                        if (obj instanceof $afm) {
                            for (var k = 0, lenk = obj.length; k < lenk; k++) {
                                node = obj[k];
                                if (node.nodeName != nundefined && node.nodeName.toLowerCase() === "script" && (!node.type || node.type.toLowerCase() === "text/javascript")) {
                                    window["eval"](node.innerHTML);
                                } else {
                                    _insertFragments($(node), this[i], insert);
                                }
                            }
                        } else {
                            insert != nundefined ? this[i].insertBefore(obj, this[i].firstChild) : this[i].appendChild(obj);
                        }
                    }
                }
                return this;
            },
            get: function(index) {
                index = index == nundefined ? null : index;
                if (index < 0) index += this.length;
                if (index === null) {
                    var elems = [];
                    for (var i = 0; i < this.length; i++) {
                        elems.push(this[i]);
                    }
                    return elems;
                }
                return this[index] ? this[index] : undefined;
            },
            offset: function() {
                var obj;
                if (this.length === 0) return this;
                if (this[0] === window) return {
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    width: window.innerWidth,
                    height: window.innerHeight
                }; else obj = this[0].getBoundingClientRect();
                return {
                    left: obj.left + window.pageXOffset,
                    top: obj.top + window.pageYOffset,
                    right: obj.right + window.pageXOffset,
                    bottom: obj.bottom + window.pageYOffset,
                    width: obj.right - obj.left,
                    height: obj.bottom - obj.top
                };
            },
            height: function(val) {
                if (this.length === 0) return this;
                if (val != nundefined) return this.css("height", val);
                if (this[0] === this[0].window) return window.innerHeight;
                if (this[0].nodeType === this[0].DOCUMENT_NODE) return this[0].documentElement.offsetHeight; else {
                    var tmpVal = this.css("height").replace("px", "");
                    if (tmpVal) return +tmpVal; else return this.offset().height;
                }
            },
            width: function(val) {
                if (this.length === 0) return this;
                if (val != nundefined) return this.css("width", val);
                if (this[0] === this[0].window) return window.innerWidth;
                if (this[0].nodeType === this[0].DOCUMENT_NODE) return this[0].documentElement.offsetWidth; else {
                    var tmpVal = this.css("width").replace("px", "");
                    if (tmpVal) return +tmpVal; else return this.offset().width;
                }
            },
            parent: function(selector, recursive) {
                if (this.length === 0) return this;
                var elems = [];
                for (var i = 0; i < this.length; i++) {
                    var tmp = this[i];
                    while (tmp.parentNode && tmp.parentNode !== document) {
                        elems.push(tmp.parentNode);
                        if (tmp.parentNode) tmp = tmp.parentNode;
                        if (!recursive) break;
                    }
                }
                return this.setupOld($(unique(elems)).filter(selector));
            },
            parents: function(selector) {
                return this.parent(selector, true);
            },
            children: function(selector) {
                if (this.length === 0) return this;
                var elems = [];
                for (var i = 0; i < this.length; i++) {
                    elems = elems.concat(siblings(this[i].firstChild));
                }
                return this.setupOld($(elems).filter(selector));
            },
            siblings: function(selector) {
                if (this.length === 0) return this;
                var elems = [];
                for (var i = 0; i < this.length; i++) {
                    if (this[i].parentNode) elems = elems.concat(siblings(this[i].parentNode.firstChild, this[i]));
                }
                return this.setupOld($(elems).filter(selector));
            },
            contents: function(selector) {
                if (this.length === 0) return this;
                var elems = [];
                for (var i = 0; i < this.length; i++) {
                    if (this[i].parentNode) _shimNodes(this[i].childNodes, elems);
                }
                return this.setupOld($(elems).filter(selector));
            },
            closest: function(selector, context) {
                if (this.length === 0) return this;
                var elems = [], cur = this[0];
                var start = $(selector, context);
                if (start.length === 0) return $();
                while (cur && start.indexOf(cur) === -1) {
                    cur = cur !== context && cur !== document && cur.parentNode;
                }
                return $(cur);
            },
            filter: function(selector) {
                if (this.length === 0) return this;
                if (selector == nundefined) return this;
                var elems = [];
                for (var i = 0; i < this.length; i++) {
                    var val = this[i];
                    if (val.parentNode && $(selector, val.parentNode).indexOf(val) >= 0) elems.push(val);
                }
                return this.setupOld($(unique(elems)));
            },
            not: function(selector) {
                if (this.length === 0) return this;
                var elems = [];
                for (var i = 0; i < this.length; i++) {
                    var val = this[i];
                    if (val.parentNode && $(selector, val.parentNode).indexOf(val) === -1) elems.push(val);
                }
                return this.setupOld($(unique(elems)));
            },
            data: function(key, value) {
                return this.attr("data-" + key, value);
            },
            end: function() {
                return this.oldElement != nundefined ? this.oldElement : $();
            },
            clone: function(deep) {
                deep = deep === false ? false : true;
                if (this.length === 0) return this;
                var elems = [];
                for (var i = 0; i < this.length; i++) {
                    elems.push(this[i].cloneNode(deep));
                }
                return $(elems);
            },
            size: function() {
                return this.length;
            },
            serialize: function() {
                if (this.length === 0) return "";
                var serializeFn = function(elem) {
                    var type = elem.getAttribute("type");
                    if (elem.nodeName.toLowerCase() !== "fieldset" && !elem.disabled && type !== "submit" && type !== "reset" && type !== "button" && (type !== "radio" && type !== "checkbox" || elem.checked)) {
                        if (elem.getAttribute("name")) {
                            if (elem.type === "select-multiple") {
                                for (var j = 0; j < elem.options.length; j++) {
                                    if (elem.options[j].selected) params.push(elem.getAttribute("name") + "=" + encodeURIComponent(elem.options[j].value));
                                }
                            } else params.push(elem.getAttribute("name") + "=" + encodeURIComponent(elem.value));
                        }
                    }
                };
                var params = [];
                for (var i = 0; i < this.length; i++) {
                    this.slice.call(this[i].elements).forEach(serializeFn);
                }
                return params.join("&");
            },
            eq: function(ind) {
                return $(this.get(ind));
            },
            index: function(elem) {
                return elem ? this.indexOf($(elem)[0]) : this.parent().children().indexOf(this[0]);
            },
            is: function(selector) {
                return !!selector && this.filter(selector).length > 0;
            },
            add: function(selector) {
                var els = $(selector);
                var i, len = els.length;
                for (i = 0; i < len; i++) {
                    this[this.length++] = els[i];
                }
                return this;
            }
        };
        function empty() {}
        $.ajaxSettings = {
            type: "GET",
            beforeSend: empty,
            success: empty,
            error: empty,
            complete: empty,
            context: undefined,
            timeout: 0,
            crossDomain: null,
            processData: true
        };
        $.jsonP = function(options) {
            if (isWin8) {
                options.type = "get";
                options.dataType = null;
                return $.get(options);
            }
            var callbackName = "jsonp_callback" + ++_jsonPID;
            var abortTimeout = "", context, callback;
            var script = document.createElement("script");
            var abort = function() {
                $(script).remove();
                if (window[callbackName]) window[callbackName] = empty;
            };
            window[callbackName] = function(data) {
                clearTimeout(abortTimeout);
                $(script).remove();
                delete window[callbackName];
                options.success.call(context, data);
            };
            if (options.url.indexOf("callback=?") !== -1) {
                script.src = options.url.replace(/=\?/, "=" + callbackName);
            } else {
                callback = options.jsonp ? options.jsonp : "callback";
                if (options.url.indexOf("?") === -1) {
                    options.url += "?" + callback + "=" + callbackName;
                } else {
                    if (options.url.indexOf("callback=") !== -1) {
                        var searcher = "callback=";
                        var offset = options.url.indexOf(searcher) + searcher.length;
                        var amp = options.url.indexOf(offset);
                        if (amp === -1) amp = options.url.length;
                        var oldCB = options.url.substr(offset, amp);
                        options.url = options.url.replace(searcher + oldCB, searcher + callbackName);
                        oldCB = oldCB.replace("window.", "");
                        options.success = window[oldCB];
                    } else {
                        options.url += "&" + callback + "=" + callbackName;
                    }
                }
                script.src = options.url;
            }
            if (options.error) {
                script.onerror = function() {
                    clearTimeout(abortTimeout);
                    options.error.call(context, "", "error");
                };
            }
            $("head").append(script);
            if (options.timeout > 0) abortTimeout = setTimeout(function() {
                options.error.call(context, "", "timeout");
            }, options.timeout);
            return {};
        };
        $.ajax = function(opts) {
            var xhr;
            var deferred = $.Deferred();
            var url;
            if (typeof opts === "string") {
                var oldUrl = opts;
                opts = {
                    url: oldUrl
                };
            }
            var settings = opts || {};
            for (var key in $.ajaxSettings) {
                if (typeof settings[key] === "undefined") settings[key] = $.ajaxSettings[key];
            }
            try {
                if (!settings.url) settings.url = window.location;
                if (!settings.headers) settings.headers = {};
                if (!("async" in settings) || settings.async !== false) settings.async = true;
                if (settings.processData && $.isObject(settings.data)) settings.data = $.param(settings.data);
                if (settings.type.toLowerCase() === "get" && settings.data) {
                    if (settings.url.indexOf("?") === -1) settings.url += "?" + settings.data; else settings.url += "&" + settings.data;
                }
                if (settings.data) {
                    if (!settings.contentType && settings.contentType !== false) settings.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
                }
                if (!settings.dataType) settings.dataType = "text/html"; else {
                    switch (settings.dataType) {
                      case "script":
                        settings.dataType = "text/javascript, application/javascript";
                        break;

                      case "json":
                        settings.dataType = "application/json";
                        break;

                      case "xml":
                        settings.dataType = "application/xml, text/xml";
                        break;

                      case "html":
                        settings.dataType = "text/html";
                        break;

                      case "text":
                        settings.dataType = "text/plain";
                        break;

                      case "jsonp":
                        return $.jsonP(opts);

                      default:
                        settings.dataType = "text/html";
                        break;
                    }
                }
                if (/=\?/.test(settings.url)) {
                    return $.jsonP(settings);
                }
                if (settings.crossDomain === null) settings.crossDomain = /^([\w-]+:)?\/\/([^\/]+)/.test(settings.url) && RegExp.$2 !== window.location.host;
                if (!settings.crossDomain) settings.headers = $.extend({
                    "X-Requested-With": "XMLHttpRequest"
                }, settings.headers);
                var abortTimeout;
                var context = settings.context;
                var protocol = /^([\w-]+:)\/\//.test(settings.url) ? RegExp.$1 : window.location.protocol;
                xhr = new window.XMLHttpRequest();
                $.extend(xhr, deferred.promise);
                xhr.onreadystatechange = function() {
                    var mime = settings.dataType;
                    if (xhr.readyState === 4) {
                        clearTimeout(abortTimeout);
                        var result, error = false;
                        var contentType = xhr.getResponseHeader("content-type") || "";
                        if (xhr.status >= 200 && xhr.status < 300 || xhr.status === 0 && protocol === "file:") {
                            if (contentType === "application/json" || mime === "application/json" && !/^\s*$/.test(xhr.responseText)) {
                                try {
                                    result = JSON.parse(xhr.responseText);
                                } catch (e) {
                                    error = e;
                                }
                            } else if (contentType.indexOf("javascript") !== -1) {
                                try {
                                    result = xhr.responseText;
                                    window["eval"](result);
                                } catch (e) {
                                    console.log(e);
                                }
                            } else if (mime === "application/xml, text/xml") {
                                result = xhr.responseXML;
                            } else if (mime === "text/html") {
                                result = xhr.responseText;
                                $.parseJS(result);
                            } else result = xhr.responseText;
                            if (xhr.status === 0 && result.length === 0) error = true;
                            if (error) {
                                settings.error.call(context, xhr, "parsererror", error);
                                deferred.reject.call(context, xhr, "parsererror", error);
                            } else {
                                deferred.resolve.call(context, result, "succes", xhr);
                                settings.success.call(context, result, "success", xhr);
                            }
                        } else {
                            error = true;
                            deferred.reject.call(context, xhr, "error");
                            settings.error.call(context, xhr, "error");
                        }
                        var respText = error ? "error" : "success";
                        settings.complete.call(context, xhr, respText);
                    }
                };
                xhr.open(settings.type, settings.url, settings.async);
                if (settings.withCredentials) xhr.withCredentials = true;
                if (settings.contentType) settings.headers["Content-Type"] = settings.contentType;
                for (var name in settings.headers) if (typeof settings.headers[name] === "string") xhr.setRequestHeader(name, settings.headers[name]);
                if (settings.beforeSend.call(context, xhr, settings) === false) {
                    xhr.abort();
                    return false;
                }
                if (settings.timeout > 0) abortTimeout = setTimeout(function() {
                    xhr.onreadystatechange = empty;
                    xhr.abort();
                    settings.error.call(context, xhr, "timeout");
                }, settings.timeout);
                xhr.send(settings.data);
            } catch (e) {
                deferred.resolve(context, xhr, "error", e);
                settings.error.call(context, xhr, "error", e);
            }
            return xhr;
        };
        $.get = function(url, success) {
            return this.ajax({
                url: url,
                success: success
            });
        };
        $.post = function(url, data, success, dataType) {
            if (typeof data === "function") {
                success = data;
                data = {};
            }
            if (dataType === nundefined) dataType = "html";
            return this.ajax({
                url: url,
                type: "POST",
                data: data,
                dataType: dataType,
                success: success
            });
        };
        $.getJSON = function(url, data, success) {
            if (typeof data === "function") {
                success = data;
                data = {};
            }
            return this.ajax({
                url: url,
                data: data,
                success: success,
                dataType: "json"
            });
        };
        $.getScript = function(url, success) {
            var isCrossDomain = /^([\w-]+:)?\/\/([^\/]+)/.test(url);
            if (isCrossDomain) {
                var deferred = $.Deferred();
                var scr = $.create("script", {
                    async: true,
                    src: url
                }).get(0);
                scr.onload = function() {
                    success && success();
                    deferred.resolve.call(this, "success");
                    $(this).remove();
                };
                scr.onerror = function() {
                    $(this).remove();
                    deferred.reject.call(this, "success");
                };
                document.head.appendChild(scr);
                return deferred.promise;
            } else {
                return this.ajax({
                    url: url,
                    success: success,
                    dataType: "script"
                });
            }
        };
        $.parseJSON = function(string) {
            return JSON.parse(string);
        };
        $.parseXML = function(string) {
            if (isWin8) {
                MSApp.execUnsafeLocalFunction(function() {
                    return new DOMParser().parseFromString(string, "text/xml");
                });
            } else return new DOMParser().parseFromString(string, "text/xml");
        };
        function detectUA($, userAgent) {
            $.os = {};
            $.os.webkit = userAgent.match(/WebKit\/([\d.]+)/) ? true : false;
            $.os.android = userAgent.match(/(Android)\s+([\d.]+)/) || userAgent.match(/Silk-Accelerated/) ? true : false;
            $.os.androidICS = $.os.android && userAgent.match(/(Android)\s4/) ? true : false;
            $.os.ipad = userAgent.match(/(iPad).*OS\s([\d_]+)/) ? true : false;
            $.os.iphone = !$.os.ipad && userAgent.match(/(iPhone\sOS)\s([\d_]+)/) ? true : false;
            $.os.ios7 = ($.os.ipad || $.os.iphone) && userAgent.match(/7_/) ? true : false;
            $.os.webos = userAgent.match(/(webOS|hpwOS)[\s\/]([\d.]+)/) ? true : false;
            $.os.touchpad = $.os.webos && userAgent.match(/TouchPad/) ? true : false;
            $.os.ios = $.os.ipad || $.os.iphone;
            $.os.playbook = userAgent.match(/PlayBook/) ? true : false;
            $.os.blackberry10 = userAgent.match(/BB10/) ? true : false;
            $.os.blackberry = $.os.playbook || $.os.blackberry10 || userAgent.match(/BlackBerry/) ? true : false;
            $.os.chrome = userAgent.match(/Chrome/) ? true : false;
            $.os.opera = userAgent.match(/Opera/) ? true : false;
            $.os.fennec = userAgent.match(/fennec/i) ? true : userAgent.match(/Firefox/) ? true : false;
            $.os.ie = userAgent.match(/MSIE 10.0/i) || userAgent.match(/Trident\/7/i) ? true : false;
            $.os.ieTouch = $.os.ie && userAgent.toLowerCase().match(/touch/i) ? true : false;
            $.os.tizen = userAgent.match(/Tizen/i) ? true : false;
            $.os.supportsTouch = window.DocumentTouch && document instanceof window.DocumentTouch || "ontouchstart" in window;
            $.os.kindle = userAgent.match(/Silk-Accelerated/) ? true : false;
            $.feat = {};
            var head = document.documentElement.getElementsByTagName("head")[0];
            $.feat.nativeTouchScroll = typeof head.style["-webkit-overflow-scrolling"] !== "undefined" && ($.os.ios || $.os.blackberry10);
            $.feat.cssPrefix = $.os.webkit ? "Webkit" : $.os.fennec ? "Moz" : $.os.ie ? "ms" : $.os.opera ? "O" : "";
            $.feat.cssTransformStart = !$.os.opera ? "3d(" : "(";
            $.feat.cssTransformEnd = !$.os.opera ? ",0)" : ")";
            if ($.os.android && !$.os.webkit) $.os.android = false;
            var items = [ "Webkit", "Moz", "ms", "O" ];
            for (var j = 0; j < items.length; j++) {
                if (document.documentElement.style[items[j] + "Transform"] === "") $.feat.cssPrefix = items[j];
            }
        }
        detectUA($, navigator.userAgent);
        $.__detectUA = detectUA;
        $.uuid = function() {
            var S4 = function() {
                return ((1 + Math.random()) * 65536 | 0).toString(16).substring(1);
            };
            return S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4();
        };
        $.getCssMatrix = function(ele) {
            if ($.is$(ele)) ele = ele.get(0);
            var matrixFn = window.WebKitCSSMatrix || window.MSCSSMatrix;
            if (ele === nundefined) {
                if (matrixFn) {
                    return new matrixFn();
                } else {
                    return {
                        a: 0,
                        b: 0,
                        c: 0,
                        d: 0,
                        e: 0,
                        f: 0
                    };
                }
            }
            var computedStyle = window.getComputedStyle(ele);
            var transform = computedStyle.webkitTransform || computedStyle.transform || computedStyle[$.feat.cssPrefix + "Transform"];
            if (matrixFn) return new matrixFn(transform); else if (transform) {
                var mat = transform.replace(/[^0-9\-.,]/g, "").split(",");
                return {
                    a: +mat[0],
                    b: +mat[1],
                    c: +mat[2],
                    d: +mat[3],
                    e: +mat[4],
                    f: +mat[5]
                };
            } else {
                return {
                    a: 0,
                    b: 0,
                    c: 0,
                    d: 0,
                    e: 0,
                    f: 0
                };
            }
        };
        $.create = function(type, props) {
            var elem;
            var f = new $afm();
            if (props || type[0] !== "<") {
                if (props.html) {
                    props.innerHTML = props.html;
                    delete props.html;
                }
                elem = document.createElement(type);
                for (var j in props) {
                    elem[j] = props[j];
                }
                f[f.length++] = elem;
            } else {
                elem = document.createElement("div");
                if (isWin8) {
                    MSApp.execUnsafeLocalFunction(function() {
                        elem.innerHTML = type.trim();
                    });
                } else elem.innerHTML = type;
                _shimNodes(elem.childNodes, f);
            }
            return f;
        };
        $.query = function(sel, what) {
            if (!sel) return new $afm();
            what = what || document;
            var f = new $afm();
            return f.selector(sel, what);
        };
        var handlers = {}, _afmid = 1;
        function afmid(element) {
            return element._afmid || (element._afmid = _afmid++);
        }
        function findHandlers(element, event, fn, selector, keepEnd) {
            event = parse(event, keepEnd);
            return (handlers[afmid(element)] || []).filter(function(handler) {
                return handler && (!event.e || handler.e === event.e) && (!event.ns || handler.ns.indexOf(event.ns) !== 0) && (!fn || handler.fn === fn || typeof handler.fn === "function" && typeof fn === "function" && handler.fn === fn) && (!selector || handler.sel === selector);
            });
        }
        function parse(event, skipPop) {
            var parts = ("" + event).split(".");
            if (skipPop !== true) parts.pop();
            return {
                e: event,
                ns: parts.join(".")
            };
        }
        function matcherFor(ns) {
            return new RegExp("(?:^| )" + ns.replace(" ", " .* ?") + "(?: |$)");
        }
        function add(element, events, fn, selector, getDelegate) {
            var id = afmid(element), set = handlers[id] || (handlers[id] = []);
            eachEvent(events, fn, function(event, fn) {
                var delegate = getDelegate && getDelegate(fn, event), callback = delegate || fn;
                var proxyfn = function(event) {
                    var result = callback.apply(element, [ event ].concat(event.data));
                    if (result === false) event.preventDefault();
                    return result;
                };
                var handler = $.extend(parse(event), {
                    fn: fn,
                    proxy: proxyfn,
                    sel: selector,
                    del: delegate,
                    i: set.length
                });
                set.push(handler);
                element.addEventListener(handler.e, proxyfn, false);
            });
        }
        function remove(element, events, fn, selector) {
            var id = afmid(element);
            eachEvent(events || "", fn, function(event, fn) {
                findHandlers(element, event, fn, selector, true).forEach(function(handler) {
                    delete handlers[id][handler.i];
                    element.removeEventListener(handler.e, handler.proxy, false);
                });
            });
        }
        $.event = {
            add: add,
            remove: remove
        };
        $.fn.bind = function(event, callback) {
            for (var i = 0, len = this.length; i < len; i++) {
                add(this[i], event, callback);
            }
            return this;
        };
        $.fn.unbind = function(event, callback) {
            for (var i = 0, len = this.length; i < len; i++) {
                remove(this[i], event, callback);
            }
            return this;
        };
        $.fn.one = function(event, callback) {
            return this.each(function(i, element) {
                add(this, event, callback, null, function(fn, type) {
                    return function() {
                        remove(element, type, fn);
                        var result = fn.apply(element, arguments);
                        return result;
                    };
                });
            });
        };
        var returnTrue = function() {
            return true;
        };
        var returnFalse = function() {
            return false;
        };
        var eventMethods = {
            preventDefault: "isDefaultPrevented",
            stopImmediatePropagation: "isImmediatePropagationStopped",
            stopPropagation: "isPropagationStopped"
        };
        function createProxy(event) {
            var proxy = $.extend({
                originalEvent: event
            }, event);
            $.each(eventMethods, function(name, predicate) {
                proxy[name] = function() {
                    this[predicate] = returnTrue;
                    if (name === "stopImmediatePropagation" || name === "stopPropagation") {
                        event.cancelBubble = true;
                        if (!event[name]) return;
                    }
                    return event[name].apply(event, arguments);
                };
                proxy[predicate] = returnFalse;
            });
            return proxy;
        }
        function addDelegate(element, event, callback, selector, data) {
            add(element, event, callback, selector, function(fn) {
                return function(e) {
                    var evt, match = $(e.target).closest(selector, element).get(0);
                    if (match) {
                        evt = $.extend(createProxy(e), {
                            currentTarget: match,
                            liveFired: element,
                            delegateTarget: element,
                            data: data
                        });
                        return fn.apply(match, [ evt ].concat([].slice.call(arguments, 1)));
                    }
                };
            });
        }
        $.fn.delegate = function(selector, event, data, callback) {
            if ($.isFunction(data)) {
                callback = data;
                data = null;
            }
            for (var i = 0, len = this.length; i < len; i++) {
                addDelegate(this[i], event, callback, selector, data);
            }
            return this;
        };
        $.fn.undelegate = function(selector, event, callback) {
            for (var i = 0, len = this.length; i < len; i++) {
                remove(this[i], event, callback, selector);
            }
            return this;
        };
        $.fn.on = function(event, selector, data, callback) {
            if ($.isFunction(data)) {
                callback = data;
                data = null;
            }
            return selector === nundefined || $.isFunction(selector) ? this.bind(event, selector) : this.delegate(selector, event, data, callback);
        };
        $.fn.off = function(event, selector, callback) {
            return selector === nundefined || $.isFunction(selector) ? this.unbind(event, selector) : this.undelegate(selector, event, callback);
        };
        $.fn.trigger = function(event, data, props) {
            if (typeof event === "string") event = $.Event(event, props);
            event.data = data;
            for (var i = 0, len = this.length; i < len; i++) {
                this[i].dispatchEvent(event);
            }
            return this;
        };
        $.Event = function(type, props) {
            var event = document.createEvent("Events"), bubbles = true;
            if (props) for (var name in props) name === "bubbles" ? bubbles = !!props[name] : event[name] = props[name];
            event.initEvent(type, bubbles, true, null, null, null, null, null, null, null, null, null, null, null, null);
            return event;
        };
        $.bind = function(obj, ev, f) {
            if (!obj) return;
            if (!obj.__events) obj.__events = {};
            if (!$.isArray(ev)) ev = [ ev ];
            for (var i = 0; i < ev.length; i++) {
                if (!obj.__events[ev[i]]) obj.__events[ev[i]] = [];
                obj.__events[ev[i]].push(f);
            }
        };
        $.trigger = function(obj, ev, args) {
            if (!obj) return;
            var ret = true;
            if (!obj.__events) return ret;
            if (!$.isArray(ev)) ev = [ ev ];
            if (!$.isArray(args)) args = [];
            for (var i = 0; i < ev.length; i++) {
                if (obj.__events[ev[i]]) {
                    var evts = obj.__events[ev[i]].slice(0);
                    for (var j = 0; j < evts.length; j++) if ($.isFunction(evts[j]) && evts[j].apply(obj, args) === false) ret = false;
                }
            }
            return ret;
        };
        $.unbind = function(obj, ev, f) {
            if (!obj.__events) return;
            if (!$.isArray(ev)) ev = [ ev ];
            for (var i = 0; i < ev.length; i++) {
                if (obj.__events[ev[i]]) {
                    var evts = obj.__events[ev[i]];
                    for (var j = 0; j < evts.length; j++) {
                        if (f == nundefined) delete evts[j];
                        if (evts[j] === f) {
                            evts.splice(j, 1);
                            break;
                        }
                    }
                }
            }
        };
        $.proxy = function(f, c, args) {
            return function() {
                if (args) return f.apply(c, args);
                return f.apply(c, arguments);
            };
        };
        function cleanUpNode(node, kill) {
            if (kill && node.dispatchEvent) {
                var e = $.Event("destroy", {
                    bubbles: false
                });
                node.dispatchEvent(e);
            }
            var id = afmid(node);
            if (id && handlers[id]) {
                for (var key in handlers[id]) node.removeEventListener(handlers[id][key].e, handlers[id][key].proxy, false);
                delete handlers[id];
            }
        }
        function cleanUpContent(node, kill) {
            if (!node) return;
            var children = node.childNodes;
            if (children && children.length > 0) {
                for (var i; i < children.length; i++) {
                    cleanUpContent(children[i], kill);
                }
            }
            cleanUpNode(node, kill);
        }
        var cleanUpAsap = function(els, kill) {
            for (var i = 0; i < els.length; i++) {
                cleanUpContent(els[i], kill);
            }
        };
        $.cleanUpContent = function(node, itself, kill) {
            if (!node) return;
            var cn = node.childNodes;
            if (cn && cn.length > 0) {
                $.asap(cleanUpAsap, {}, [ slice.apply(cn, [ 0 ]), kill ]);
            }
            if (itself) cleanUpNode(node, kill);
        };
        var timeouts = [];
        var contexts = [];
        var params = [];
        $.asap = function(fn, context, args) {
            if (!$.isFunction(fn)) throw "$.asap - argument is not a valid function";
            timeouts.push(fn);
            contexts.push(context ? context : {});
            params.push(args ? args : []);
            window.postMessage("afm-asap", "*");
        };
        window.addEventListener("message", function(event) {
            if (event.source === window && event.data === "afm-asap") {
                event.stopPropagation();
                if (timeouts.length > 0) {
                    timeouts.shift().apply(contexts.shift(), params.shift());
                }
            }
        }, true);
        var remoteJSPages = {};
        $.parseJS = function(div) {
            if (!div) return;
            if (typeof div === "string") {
                var elem = document.createElement("div");
                if (isWin8) {
                    MSApp.execUnsafeLocalFunction(function() {
                        elem.innerHTML = div;
                    });
                } else elem.innerHTML = div;
                div = elem;
            }
            var scripts = div.getElementsByTagName("script");
            div = null;
            for (var i = 0; i < scripts.length; i++) {
                if (scripts[i].src.length > 0 && !remoteJSPages[scripts[i].src] && !isWin8) {
                    var doc = document.createElement("script");
                    doc.type = scripts[i].type;
                    doc.src = scripts[i].src;
                    document.getElementsByTagName("head")[0].appendChild(doc);
                    remoteJSPages[scripts[i].src] = 1;
                    doc = null;
                } else {
                    window["eval"](scripts[i].innerHTML);
                }
            }
        };
        [ "click", "keydown", "keyup", "keypress", "submit", "load", "resize", "change", "select", "error" ].forEach(function(event) {
            $.fn[event] = function(cb) {
                return cb ? this.bind(event, cb) : this.trigger(event);
            };
        });
        [ "focus", "blur" ].forEach(function(name) {
            $.fn[name] = function(callback) {
                if (this.length === 0) return;
                if (callback) this.bind(name, callback); else {
                    for (var i = 0; i < this.length; i++) {
                        try {
                            this[i][name]();
                        } catch (e) {}
                    }
                }
                return this;
            };
        });
        $.Deferred = function() {
            return {
                reject: function() {},
                resolve: function() {},
                promise: {
                    then: function() {},
                    fail: function() {}
                }
            };
        };
        return $;
    }(window);
    window.jq = af;
    "$" in window || (window.$ = af);
    if (typeof define === "function" && define.amd) {
        define("appframework", [], function() {
            "use strict";
            return af;
        });
    } else if (typeof module !== "undefined" && module.exports) {
        module.exports.af = af;
        module.exports.$ = af;
    }
    if (!window.numOnly) {
        window.numOnly = function numOnly(val) {
            "use strict";
            if (val === undefined || val === "") return 0;
            if (isNaN(parseFloat(val))) {
                if (val.replace) {
                    val = val.replace(/[^0-9.-]/g, "");
                } else return 0;
            }
            return parseFloat(val);
        };
    }
}