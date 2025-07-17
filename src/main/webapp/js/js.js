// check UA
ua = navigator.userAgent.toLowerCase(),
    check = function (r) {
        return r.test(ua);
    },
    DOC = document,
    isStrict = DOC.compatMode === "CSS1Compat",
    isOpera = check(/opera/),
    isChrome = check(/\bchrome\b/),
    isWebKit = check(/webkit/),
    isSafari = !isChrome && check(/safari/),
    isSafapori2 = isSafari && check(/applewebkit\/4/),
    isSafari3 = isSafari && check(/version\/3/),
    isSafari4 = isSafari && check(/version\/4/),
    isIE6 = !-[1,] && !window.XMLHttpRequest,
    isIE7 = check(/msie 7/),
    isIE8 = check(/msie 8/),
    isIE678 = isIE6 || isIE7 || isIE8,
    isIE11 = check(/trident/) && check(/rv:11.0/),
    isIE = check(/msie/) || isIE11,
    isEdge = check(/edge/),
    isGecko = !isWebKit && check(/gecko/),
    isGecko2 = isGecko && check(/rv:1\.8/),
    isGecko3 = isGecko && check(/rv:1\.9/),
    isBorderBox = isIE && !isStrict,
    isWindows = check(/windows|win32/),
    isMac = check(/macintosh|mac os x/),
    isAir = check(/adobeair/),
    isLinux = check(/linux/),
    isIos = check(/\(i[^;]+;( u;)? cpu.+mac os x/),
    isIphone = check(/iphone/),
    isIpad = check(/ipad/),
    isIpod = check(/ipod/),
    isAndroid = check(/android/),
    isSymbian = check(/symbianos/),
    isWindowsphone = check(/windows phone/),
    isWeixin = check(/micromessenger/),
    isMobile = check(/iphone|ipad|ipod|android|micromessenger|windows phone|symbianos/),
    isDesktop = check(/windows|win32|macintosh|mac os x|adobeair|linux/),
    isSecure = /^https/i.test(window.location.protocol),
    isKuaizhan = check(/kznativenav/),
    isHtml5Plus = check(/html5plus/),
    inFrame = (self != top);

if (isMobile) $("body").addClass("isMobile");
if (!isMobile) $("body").addClass("isDesktop");
if (isWeixin) $("body").addClass("isWeixin swipeLeft");
if (isHtml5Plus) $("body").addClass("isHtml5Plus");
if (inFrame) $("body").addClass("inframe");

var myDate = new Date();
//var year = myDate.getYear(); //获取当前年份(2位)
var year = myDate.getFullYear(); //获取完整的年份(4位,1970)
var month = myDate.getMonth(); //获取当前月份(0-11,0代表1月)
var day = myDate.getDay(); //获取当前星期X(0-6,0代表星期天)
var hour = myDate.getHours(); //获取当前小时数(0-23)
var minute = myDate.getMinutes(); //获取当前分钟数(0-59)
var second = myDate.getSeconds(); //获取当前秒数(0-59)
var millisecond = myDate.getMilliseconds(); //获取当前毫秒数(0-999)

//图片url检测
isImgUrl = function (url) {
    if (!/http/.test(url)) return false;
    return /.jpg|.jpeg|.gif|.png|.bmp|.pic/.test(url.split("?")[0].substring(url.lastIndexOf('.')).toLowerCase());
}

//https://stackoverflow.com/questions/1462649/jquery-memory-leak-with-dom-removal
$.fn.removeWithoutLeaking = function () {
    this.each(function (i, e) {
        if (e.parentNode)
            e.parentNode.removeChild(e);
    });
};

//页签状态
function isHidden() {
    var prefixes = ['webkit', 'moz', 'ms', 'o'];
    // if 'hidden' is natively supported just return it
    if ('hidden' in document) return document.hidden;
    // otherwise loop over all the known prefixes until we find one
    for (var i = 0; i < prefixes.length; i++) {
        if ((prefixes[i] + 'Hidden') in document)
            return eval('document.' + prefixes[i] + 'Hidden');
    }
    // otherwise it's not supported
    return null;
}

// 去除微信默认参数
if (/from=[^&$?]{1,}(&|$)/.test(location.search) || /isappinstalled=[^&$?]{1,}(&|$)/.test(location.search)) {
    var newSearch = location.search.replace(/from=[^&$?]{1,}(&|$)/, '').replace(/isappinstalled=[^&$?]{1,}(&|$)/, '').replace(/&$|\?$/, '');
    var newUrl = location.origin + location.pathname + newSearch + location.hash;
    location.replace(newUrl);
}

//通用数据
var otitle = document.title;
var ourl = location.href.split("#")[0];
var favtitle = document.title.split(" · ")[0];
var favurl = location.href.split("#")[0].split("http://www.mvcat.com")[1];
var shareData = {
    title: $("meta[property='og:title']").attr("content") || favtitle,
    desc: $("meta[property='og:description']").attr("content") || $("meta[name='Description']").attr("content") || channelname + " · MVCAT" || "WWW.MVCAT.COM", //这里请特别注意是要去除html 
    link: ourl,
    imgUrl: imageurl || $("meta[property='og:image']").attr("content") || "http://www.mvcat.com/img/logo_1024_white.png",
    type: "link"
};
var oshareData = shareData;
var themecolor = "#daa520";
var counter = 0;
var jumptip = "将跳转第三方网站，可能会有广告！";

//inframe shareData
function FshareData() {
    if (inFrame && /mvcat.com/.test(parent.location)) {
        try {
            window.top.wx.updateAppMessageShareData(shareData);
            window.top.wx.updateTimelineShareData(shareData);
        } catch (err) {
        }
    }
}

FshareData();
//end inframe shareData

//清除hash
try {
    //history.pushState("", document.title, window.location.pathname);
} catch (e) {
    // window.location.hash = "";
}

var refresh = "close";
window.onunload = function () {
    if (refresh == "refresh") {
        //alert('刷新');
    }
}
window.onbeforeunload = function () {
    refresh = "refresh";
}


//转rgb
colorToRgb = function (color) {
    var div = document.createElement('div');
    div.style.backgroundColor = color;
    document.body.appendChild(div);
    var c = window.getComputedStyle(div).backgroundColor;
    document.body.removeChild(div);
    return c;
};

//textcolor
function autoTextColor(color) {
    var rgb = colorToRgb(color);
    var RgbValueArry = rgb.replace("rgb(", "").replace(")", "").split(",");
    var $grayLevel = RgbValueArry[0] * 0.299 + RgbValueArry[1] * 0.587 + RgbValueArry[2] * 0.114;
    if ($grayLevel >= 192) {
        return "#333";
    } else {
        return "#fff";
    }
}

//下载文件
function downFile(url) {
    var $eleForm = $("<form method='get'></form>");

    $eleForm.attr("action", url);

    $(document.body).append($eleForm);

    //提交表单，实现下载
    $eleForm.submit();
}

//Nanobar
!function (a) {
    "use strict";

    function c() {
        var a = document.getElementById("nanobarcss");
        if (null === a) {
            if (a = document.createElement("style"), a.type = "text/css", a.id = "nanobarcss", document.head.insertBefore(a, document.head.firstChild), !a.styleSheet) return a.appendChild(document.createTextNode(b));
            a.styleSheet.cssText = b
        }
    }

    function d(a, b) {
        a.classList ? a.classList.add(b) : a.className += " " + b
    }

    function e(a) {
        function h() {
            var d = c - e;
            .1 > d && d > -.1 ? (i(e), f = 0, c >= 100 && (b.style.height = 0, setTimeout(function () {
                a(b)
            }, 300))) : (i(c - d / 4), setTimeout(j, 16))
        }

        function i(a) {
            c = a, b.style.width = c + "%"
        }

        function j(a) {
            a >= 0 ? (e = a, f || (f = 1, h())) : f && h()
        }

        var b = document.createElement("div"), c = 0, e = 0, f = 0, g = {el: b, go: j};
        return d(b, "bar"), g
    }

    function f(a) {
        function h(a) {
            b.removeChild(a)
        }

        function i() {
            var a = e(h);
            b.appendChild(a.el), f = a.go
        }

        a = a || {};
        var f, b = document.createElement("div"), g = {
            el: b, go: function (a) {
                f(a), a >= 100 && i()
            }
        };
        return c(), d(b, "nanobar"), a.id && (b.id = a.id), a.classname && d(b, a.classname), a.target ? (b.style.position = "relative", a.target.insertBefore(b, a.target.firstChild)) : (b.style.position = "fixed", document.getElementsByTagName("body")[0].appendChild(b)), i(), g
    }

    var b = ".nanobar{width:100%;height:2px;z-index:9999;top:0}.bar{width:0;height:100%;transition:height .3s;color:#daa520;box-shadow: 0 0 0 1px inset;}";
    "object" == typeof exports ? module.exports = f : "function" == typeof define && define.amd ? define([], function () {
        return f
    }) : a.Nanobar = f
}(this);

if (!isMobile || inFrame) {
    var nanobar = new Nanobar();
    //move bar
    nanobar.go(38);
    nanobar.go(62);
    nanobar.go(90);
    nanobar.go(100);
}

//双击生成
if (!/utils|about|copyright/.test(currenturl)) {
    document.ondblclick = function (e) {
        e.preventDefault();
    }
    $(".left .submenu").first().add(".stltrigger").dblclick(function () {
        location.href = 'http://www.mvcat.com/sitefiles/services/cms/utils.aspx?type=StlTrigger&publishmentSystemID=' + siteid + '&channelID=' + channelid + '&contentID=' + contentid + '&isRedirect=true';
    })
}
//in app
if (isKuaizhan) {
    $("body").addClass("inframe inapp");
}

//ios iframe fix
if (inFrame && isIos && isSafari) $("html,body").css({"height": "100%", "overflow-y": "auto"});

/**
 * 复制字符串到剪贴板的函数
 * @param {String} value 需要被复制的字符串
 * @returns {Boolean} 操作结果
 */
function copy(value) {
    var currentFocus = document.activeElement;// 保存当前活动节点

    let input = document.createElement('input');// 创建一个input标签
    document.body.appendChild(input);// 把标签添加给body
    input.style.opacity = 0;//设置input标签设置为透明(不可见)
    input.value = value;// 把需要复制的值放到input上

    // 记录当前滚动位置, 因为添加节点并选中的时候回影响页面滚动
    let scrollY = window.scrollY;

    input.focus();// input节点获取焦点
    input.setSelectionRange(0, input.value.length);// 选中input框中的所有文字

    var res = document.execCommand('copy', true);// 复制文字并获取结果

    currentFocus.focus();// 之前活动节点获得焦点
    document.body.removeChild(input);// 删除添加的input节点

    // 页面滚动到之前位置
    window.scrollTo(0, scrollY);

    return res;// 返回操作结果
}


//cookies
function saveCookie(name, value, days, domain)
//写cookies函数
{
    var exp = new Date();
    exp.setTime(exp.getTime() + days * 24 * 60 * 60 * 1000);
    var domain = domain || ".mvcat.com";
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString() + ";domain=" + domain + ";path=/";

}

function getCookie(name)
//取cookies函数        
{
    var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
    if (arr !== null) {
        return unescape(arr[2]);
    } else {
        return null;
    }
}

function delCookie(name, domain)
//删除cookie
{
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = getCookie(name);
    var domain = domain || ".mvcat.com";
    if (cval !== null) {
        document.cookie = name + "=" + escape(cval) + ";expires=" + exp.toGMTString() + ";domain=" + domain + ";path=/";
    }

}

//rgb2hex
function rgb2hex(rgb) {
    rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
    if (!rgb) return;

    function hex(x) {
        return ("0" + parseInt(x).toString(16)).slice(-2);
    }

    return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
}

//计算颜色值的反色，colorStr格式为：rgb(0,0,0),#000000或者#f00
function reversalColor(colorStr) {
    var sixNumReg = /^#(\d{2})(\d{2})(\d{2})$/ig;
    var threeNumReg = /^#(\d{1})(\d{1})(\d{1})$/ig;
    var rgbReg = /^rgb\((\d{1,3}), (\d{1,3}), (\d{1,3})\)$/ig;
    var c1 = 0,
        c2 = 0,
        c3 = 0;
    var parseHexToInt = function (hex) {
        return parseInt(hex, 16);
    };
    var parseIntToHex = function (int) {
        return int.toString(16);
    };
    this.parse = function () {
        if (sixNumReg.test(colorStr)) {
            sixNumReg.exec(colorStr);
            c1 = parseHexToInt(RegExp.$1);
            c2 = parseHexToInt(RegExp.$2);
            c3 = parseHexToInt(RegExp.$3);
        } else if (threeNumReg.test(colorStr)) {
            threeNumReg.exec(colorStr);
            c1 = parseHexToInt(RegExp.$1 + RegExp.$1);
            c2 = parseHexToInt(RegExp.$2 + RegExp.$2);
            c3 = parseHexToInt(RegExp.$3 + RegExp.$3);
        } else if (rgbReg.test(colorStr)) {
            //rgb color 直接就是十进制，不用转换
            rgbReg.exec(colorStr);
            c1 = RegExp.$1;
            c2 = RegExp.$2;
            c3 = RegExp.$3;
        } else {
            throw new Error("Error color string format. eg.[rgb(0,0,0),#000000,#f00]");
        }
        c1 = parseIntToHex(255 - c1);
        c2 = parseIntToHex(255 - c2);
        c3 = parseIntToHex(255 - c3);
        return '#' + (c1 < 10 ? '0' + c1 : c1) + (c2 < 10 ? '0' + c2 : c2) + (c3 < 10 ? '0' + c3 : c3);
    };
}

//反色
function oppositeColor(a) {
    a = a.replace('#', '');
    var c16, c10, max16 = 15,
        b = [];
    for (var i = 0; i < a.length; i++) {
        c16 = parseInt(a.charAt(i), 16); //  to 16进制
        c10 = parseInt(max16 - c16, 10); // 10进制计算
        b.push(c10.toString(16)); // to 16进制
    }
    return '#' + b.join('');
}


//震动
function startVibrate(duration) {
    if (isMobile && navigator.vibrate) {
        window.navigator.vibrate(duration);
    }
}

var vibrateInterval;

//在给定的持续时间和间隔时开始持续的振动
//假定一个数字值
function startPeristentVibrate(duration, interval) {
    if (navigator.vibrate) {
        vibrateInterval = setInterval(function () {
            startVibrate(duration);
        }, interval);
    }
}

// 停止震动
function stopVibrate() {
    // 清除间隔和停止持续振动
    if (vibrateInterval) clearInterval(vibrateInterval);
    startVibrate(0);
}

//提示
var jsalertTimer;
$("body").append('<div class="jsalert none"></div>');

function jsalert(txt, time) {
    if (!txt) return;
    var a = $(".jsalert");
    a.html(txt);
    a.css("margin-left", -(a.outerWidth(false) / 2));
    //a.css("margin-top", - (a.outerHeight(false)/2));
    var t = time || 1500;
    a.stop(true, true).slideDown(300);
    clearTimeout(jsalertTimer);
    jsalertTimer = setTimeout(function () {
        a.slideUp(1000);
    }, t);
    startVibrate(30);
    $(".jsalert").click(function () {
        $(".jsalert").slideUp(10);
    })
}

//获取url参数
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]);
    return null;
}

//url转化
function str2num(str) {
    if (str == "") return;
    var num_out = "";
    var str_in = escape(str);
    for (i = 0; i < str_in.length; i++) {
        num_out += str_in.charCodeAt(i) - 23;
    }
    return "mvcat:" + num_out;
}

//sidebar 默认展开
//if($(".swipeLeft,.swipeRight,.inframe").length==0 && !$("body").width()<768){
//if(getCookie("sidebar")=="on"){
//	$("body").removeClass("swipeLeft swipeRight").addClass("swipeRight");
//模拟window resize
//	$(window).trigger("resize");
//}
//if(getCookie("sidebar")=="off"){
//	$("body").removeClass("swipeLeft swipeRight").addClass("swipeLeft");
//	//模拟window resize
//	$(window).trigger("resize");
//}
//}

//showleft
if ($(".left").length > 0) {
    $("body").append('<a class="showleft"></a>');
    $(".showleft").click(function () {
        if ($(".swipeLeft,.swipeRight").length > 0) {
            $("body").toggleClass("swipeLeft swipeRight");
        } else if ($(".swipeLeft,.swipeRight").length == 0 && $("body").width() < 767) {
            $("body").addClass("swipeRight");
        } else {
            $("body").addClass("swipeLeft");
        }
        startVibrate(30);
        //sidebar cookie
        //if($("body").hasClass("swipeRight")){saveCookie("sidebar","on");}else{saveCookie("sidebar","off");};
        //模拟window resize
        $(window).trigger("resize");
    }) //end click
}//end showleft

//右侧工具栏
$("body").append('<div id="ftool"></div>');

//左侧开关
$(".left").append('<div id="lcontrol" class="submenu"></div>');


//tabmode
var tabmode = true;
$("#lcontrol").append('<input type="checkbox" id="tabmode" class="checkbox-ios tabmode"><label class="tabmode tooltip" for="tabmode" onclick="if(tabmode){tabmode=false;jsalert(\'窗口模式：新页面在新窗口打开\', 3000);saveCookie(\'tabmode\',\'off\');}else{tabmode=true;jsalert(\'折叠模式：新页面在本页显示\', 3000);saveCookie(\'tabmode\',\'on\');};"></label>');
if (getCookie("tabmode") == "off") {//新窗口
    tabmode = false;
    $("#tabmode").prop("checked", true)
}


//playtone
var playtone = false;
if (!isMobile)
    $("#lcontrol").append('<input type="checkbox" id="playtone" class="checkbox-ios playtone desktop"><label class="playtone tooltip" title2="快捷键 T" for="playtone" onclick="if(playtone){playtone=false;jsalert(\'关闭音效\', 3000);saveCookie(\'playtone\',\'off\');}else{playtone=true;playTone();jsalert(\'开启音效：鼠标经过链接会有声音提示\', 3000);saveCookie(\'playtone\',\'on\');};"></label>');
if (getCookie("playtone") == "on") {
    playtone = true;
    playTone();
    $("#playtone").prop("checked", true)
}

//nightmode
$("#lcontrol").append('<input type="checkbox" id="nightmode" class="checkbox-ios nightmode"><label class="nightmode tooltip" title2="快捷键 N" for="nightmode" onclick="if(nightmode){nightmoder(\'off\');saveCookie(\'nightmode\',\'off\');}else{nightmoder(\'on\');saveCookie(\'nightmode\',\'on\');};return false;"></label>');
//nightmoder
var nightmode = false;

function nightmoder(trigger) {
    if (trigger == "on") {
        $("body").addClass("nightmode bgmask");
        nightmode = true;
        $("#nightmode").prop("checked", true);
        $(window).trigger("resize");
    } else {
        $("body").removeClass("nightmode");
        if ($("body.musicmask").length == 0) $("body").removeClass("bgmask");
        nightmode = false;
        $("#nightmode").prop("checked", false);
        $(window).trigger("resize");
    }
}

if (getCookie("nightmode") == "on") {
    nightmoder("on");

    jsalert("夜间模式已开启", 3000);
}


//fullscreen
$("#lcontrol").append('<input type="checkbox fullscreen" id="fullscreen" class="checkbox-ios fullscreen "><label class="fullscreen tooltip" title2="快捷键 F" for="fullscreen" onclick="if(fullscreen){exitFullScreen()}else{fullScreen()};"></label>');


//播放按钮
function playbutton(e) {
    e.each(function () {
        if ($(this).find(".play").length > 0) return;
        if ($(this).is(".poster[data-video-title]")) {
            $(this).append('<a href="http://www.mvcat.com/vsearch/?type=online&word=' + $(this).attr('data-video-title') + '" class="play"></a>');
            return;
        } else if ($(this).is(".poster[data-video]")) {
            if (/购票/.test($(this).attr("data-video"))) {
                $(this).append('<a href="' + $(this).attr("data-video") + '" class="play ticket" rel="nofollow"></a>');
            } else if (/http/.test($(this).attr("data-video")) && !/163.com|.mp3/.test($(this).attr("data-video"))) {
                $(this).append('<a href="' + $(this).attr("data-video") + '" class="play" rel="nofollow"></a>');
            } else {
                $(this).append('<span class="play link"></a>');
            }
        }
    })
}


//playbutton($(".poster[data-video],.poster[data-video-title]"));


//视频播放器
function loadVideo(e, url, poster, autoplay) {
    if (/\.mp4/.test(url)) {
        e.prepend('<video ' + autoplay + ' controls preload="auto" width="100%" height="100%" poster="' + poster + '" x-webkit-airplay="true"><source src="' + url + '" type="video/mp4" /></video>');
    }
} //end loadVideo


//内容搜索
function moviefinder(e) {

    if ($("body.content.movies,body.content.movie,body.content.date,body.content.history").length == 0) return; //限定内容页

    //movies
    e.find("h3").each(function () {
        var word = $(this).text().toLowerCase();
        if (word == "") return;
        if (word.split(" ")[0] == "") {
            word = word.split(" ")[1]
        }
        ;
        if (word == "") return;
        if (/《/.test(word) && /》/.test(word)) {
            word = word.split("《")[1].split("》")[0];
        } else {
            word = word.split("(")[0].split("（")[0].split(" ")[0].replace(/[^\u4e00-\u9fa5]/g, "");
        }
        if (word == "") return;
        $(this).addClass("insearch").append('<input id="submit" type="submit" value=" " onClick="//insearch(\'' + word + '\',\'Title\')" />').wrap('<a class="moviefinder clear" href="http://www.mvcat.com/search/?type=single&word=' + word + '"></a>')
    })
    //内容em标签
    e.find("em").each(function () {
        var word = $(this).text();
        if ($(this).parents("h3,blockquote").length > 0) return;
        $(this).html('<a href="http://www.mvcat.com/search/?type=single&word=' + word.replace(/[《|》]/g, "") + '">&nbsp;' + word + '&#xe668;&nbsp;</a>');
        if (!isMobile) {
            $(this).find("a").addClass("hide").mouseover(function () {
                $(this).removeClass('hide');
            })
        } else {
            $(this).find("a").addClass("theme");
        }
    })

    if (!isMobile) {
        jsalert("试试鼠标选中片名！", 3000);
    }
    //movies end


    //内容a标签
    e.find("a").each(function () {
        if (/music.163.com/.test($(this).attr("href"))) { //音乐链接
            $(this).text("[点击试听]");
            $(this).attr("data-href", $(this).attr("href")).removeAttr("href");
            $(this).click(function (event) {

                event.preventDefault();
                bgmPlay($(this).attr("data-href"))
            });
        } else { //非音乐链接
            if (/magnet:|ed2k:|thunder:|pan.baidu.com/.test($(this).text())) { //下载链接
                $(this).text("[点击下载]");
            } else if (/http:|https:/.test($(this).text())) {
                $(this).text("[点击前往]");
            }
        }
    }) //end a标签

} //end moviefinder

moviefinder($("#content"));

function movielite() {
    if ($(".moviefinder").length > 0) {
        if (!freemode) {
            $('#content .ipage>*').not('.moviefinder').hide();
            $('#content').on('mouseover', '.moviefinder', function () {
                $('#content .ipage>*').not('.moviefinder').hide();
                $(this).nextUntil('.moviefinder').slideDown(0);
            });
            $('body').addClass('movielite');
        } else {
            $('#content .ipage>*').show();
            $('body').removeClass('movielite');
        }
    }
}

var freemode = true;
$("#lcontrol").append('<input type="checkbox" id="freemode" class="checkbox-ios freemode"><label class="freemode tooltip" for="freemode" onclick="if(freemode){freemode=false;jsalert(\'<p><自律模式><\/p>隐藏非必看电影<br \/>精简显示内容<br \/>无广告\', 10000);saveCookie(\'freemode\',\'off\');$(\'body\').addClass(\'selfmode\');}else{freemode=true;jsalert(\'<p>>自由模式<<\/p>网站内容不受限制\', 3000);saveCookie(\'freemode\',\'on\');$(\'body\').removeClass(\'selfmode\');};movielite();"></label>');
if (getCookie("freemode") == "off") {//自律模式
    freemode = false;
    $("#freemode").prop("checked", true);
    $("body").addClass("selfmode");
    movielite();
    //if(!inFrame)jsalert("<p><自律模式><\/p>主动求索 拒绝推送",5000);
}

//mvcaturl
function mvcaturl(url) {
    if (/www.mvcat.com\/api\/|api.mvcat.com/.test(url)) {
        return url;
    } else if (/#vip/.test(url.toLowerCase())) {
        url = "http://www.mvcat.com/player/?url=" + url;
    } else if (url.indexOf("youku.com/v_show/id_") != -1 && isMobile) { //https://v.youku.com/v_show/id_XMzcyOTcxODE5Ng==.html
        var vid = url.split("id_")[1].split(".")[0];
        url = "http://player.youku.com/embed/" + vid;
    } else if (url.indexOf("bilibili.com/video/av") != -1) { //https://www.bilibili.com/video/av27123788/
        var vid = url.split("bilibili.com/video/av")[1].split("/")[0];
        url = "http://player.bilibili.com/player.html?aid=" + vid;
    } else if (url.indexOf("v.qq.com/x/page/") != -1 && isMobile) { //http://v.qq.com/x/page/p0726u76bif.html
        var vid = url.split("v.qq.com/x/page/")[1].split(".")[0];
        url = "http://v.qq.com/iframe/player.html?vid=" + vid;
    } else {
        url = url;
    }

    return url;
}

//end mvcaturl

function Base64() {

    // private property
    _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    // public method for encoding
    this.encode = function (input) {
        var output = "";
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
        var i = 0;
        input = _utf8_encode(input);
        while (i < input.length) {
            chr1 = input.charCodeAt(i++);
            chr2 = input.charCodeAt(i++);


            chr3 = input.charCodeAt(i++);
            enc1 = chr1 >> 2;
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
            enc4 = chr3 & 63;
            if (isNaN(chr2)) {
                enc3 = enc4 = 64;
            } else if (isNaN(chr3)) {
                enc4 = 64;
            }

            output = output +
                _keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
                _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
        }
        return output;
    }

    // public method for decoding
    this.decode = function (input) {
        var output = "";
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;
        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        while (i < input.length) {
            enc1 = _keyStr.indexOf(input.charAt(i++));
            enc2 = _keyStr.indexOf(input.charAt(i++));
            enc3 = _keyStr.indexOf(input.charAt(i++));
            enc4 = _keyStr.indexOf(input.charAt(i++));
            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;
            output = output + String.fromCharCode(chr1);
            if (enc3 != 64) {
                output = output + String.fromCharCode(chr2);
            }
            if (enc4 != 64) {
                output = output + String.fromCharCode(chr3);
            }
        }
        output = _utf8_decode(output);
        return output;
    }

    // private method for UTF-8 encoding
    _utf8_encode = function (string) {
        string = string.replace(/\r\n/g, "\n");
        var utftext = "";
        for (var n = 0; n < string.length; n++) {
            var c = string.charCodeAt(n);

            if (c < 128) {
                utftext += String.fromCharCode(c);
            } else if ((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            } else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }
        return utftext;
    }

    // private method for UTF-8 decoding
    _utf8_decode = function (utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;
        while (i < utftext.length) {
            c = utftext.charCodeAt(i);
            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            } else if ((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i + 1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            } else {
                c2 = utftext.charCodeAt(i + 1);
                c3 = utftext.charCodeAt(i + 2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }
        }
        return string;
    }
}

function rawurlencode(str) {
    var base64 = new Base64();
    var str = str;
    str = base64.encode(str);
    str = str.split('/').join('_').split('+').join('-');
    str = (str + '').toString();
    return encodeURIComponent(str).replace(/!/g, '%21').replace(/'/g, '%27').replace(/\(/g, '%28').replace(/\)/g, '%29').replace(/\*/g, '%2A');
}


//滚动还原
var popScroll = (function (className) {
    var scrollTop;
    return {
        afterOpen: function () {
            scrollTop = $(document).scrollTop();
            $('body').addClass(className);
            document.body.style.top = -scrollTop + 'px';
        },
        beforeClose: function () {
            $('body').removeClass(className);
            $(document).scrollTop(scrollTop);
        }
    };
})('popmaskon');


function popIframe(src, target) {

    //新窗口打开
    if (target == "_blank" || !tabmode || isIos || src.substr(0, 5) == "https") {
        if (isMobile) {
            location.href = src;
        } else {
            window.open(src);
        }
        return;
    }

    //去除left
    if ($("body").width() < 768) $('body').addClass('swipeLeft').removeClass('swipeRight');

    if ($("#popIframe").length == 0) $("body").append('<div class="popmask popIframe loading" id="popIframe"><iframe name="popIframe" frameborder="0" allowfullscreen="true" allowtransparency="true"></iframe><a class="closemask" id="closemask"></a></div>');
    if (!/mvcat.com/.test(src.toLowerCase()) && /v.youku.com|tudou.com|iqiyi.com|v.qq.com|letv.com|le.com|mgtv.com|pptv.com|tv.sohu.com|acfun.cn|acfun.tv|bilibili.com|tv.cctv.com|m1905.com|v.yinyuetai.com|www.56.com|vlook.cn|v.ku6.com|miaopai.com|weibo.com|v.17173.com|v.ifeng.com|meipai.com|weishi.com|\.m3u8|\.mp4|#vip/.test(src.toLowerCase())) $("#popIframe").append('<div id="magic" target="popIframe" onmouseup="$(\'#popIframe iframe\').attr(\'src\', \'http://www.mvcat.com/player/?url=' + src + '\');$(this).remove();" style="display: block!important;"></div>');
    try {
        popScroll.afterOpen();
    } catch (err) {
    }//防止滚动
    if (/mvcat.com\/home\//.test(src.toLowerCase())) $(".popIframe,body").addClass("pophome");
    $(".jsalert").click();
    $("#popIframe iframe").attr("src", src).load(function () {
        $(".popIframe").removeClass("loading");
    });
    setTimeout(function () {
        $('#closemask').click(function () {
            var mask = $(this).parent('.popIframe');
            if ($("body").width() < 768) {
                mask.animate({
                    'top': '110%'
                }, 300, function () {
                    mask.removeWithoutLeaking();
                });
            } else {
                mask.animate({
                    'left': '110%'
                }, 300, function () {
                    mask.removeWithoutLeaking();
                });
            }
            shareData = oshareData; //还原分享数据
            try {
                wx.updateAppMessageShareData(shareData);
                wx.updateTimelineShareData(shareData);
            } catch (err) {
            }
            $("body").removeClass("pophome");//用户中心
            popScroll.beforeClose(); //解除防滚动
            //清除hash
            try {
                history.pushState('', document.title, ourl);
            } catch (e) {
                window.location.hash = "";
            }
            //刷新登录状态
            if ($(".pophome").length > 0) location.reload();
        })
        $("#closemask").swipe({
            swipe: function () {
                $('#closemask').click();
            }
        });

    }, 300) //end setTimeout

    $("body.music.content .left").css("opacity", "1");
    if (!/search/.test(src) && src.indexOf(window.location.hash.split("#")[1]) == -1) window.location.hash = src; //添加hash

} //end popIframe

//fullscreen
//if($("body.music").length>0){$("#ftool").prepend('<a class="icon ffullscreen tooltip" title="全屏" onclick="if(fullscreen){exitFullScreen()}else{fullScreen()}">▣</a>');}
var fullscreen = false;

function fullScreen() {
    var el = document.documentElement;
    var rfs = el.requestFullScreen || el.webkitRequestFullScreen ||
        el.mozRequestFullScreen || el.msRequestFullScreen;
    if (typeof rfs != "undefined" && rfs) {
        rfs.call(el);
        fullscreen = true;
        if (!isMobile) jsalert("Esc可退出全屏");
    } else if (typeof window.ActiveXObject != "undefined") {
        //for IE，这里其实就是模拟了按下键盘的F11，使浏览器全屏
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript != null) {
            wscript.SendKeys("{F11}");
            fullscreen = true;
            if (!isMobile) jsalert("F11可退出全屏");
        }
    } else {
        fullscreen = false;
        $("#fullscreen,#fullscreen+label,#ftool .fullscreen").removeWithoutLeaking();
    }
}


function exitFullScreen() {
    var el = document;
    var cfs = el.cancelFullScreen || el.webkitCancelFullScreen ||
        el.mozCancelFullScreen || el.exitFullScreen;
    if (typeof cfs != "undefined" && cfs) {
        cfs.call(el);
        fullscreen = false;
        $("#fullscreen").removeAttr("checked");

    } else if (typeof window.ActiveXObject != "undefined") {
        //for IE，这里和fullScreen相同，模拟按下F11键退出全屏
        var wscript = new ActiveXObject("WScript.Shell");
        if (wscript != null) {
            wscript.SendKeys("{F11}");
            fullscreen = false;
        }
    }

}

//end fullscreen

//popImg
function popImg(e) {
    if (isImgUrl(e)) {
        $("body").append('<img src="' + e + '" id="tempImg" style="display:none" />');
        var imgs = $("#tempImg");
        start(imgs);
        $("#tempImg").removeWithoutLeaking();
    } else if (e.is("img")) {
        var imgs = e;
        start(imgs);
    } else {
        var imgs = e.find("img").not("a img,#infscr-loading img");
        e.unbind("click");
        e.on("click", "img:not('a img,#infscr-loading img')", function () {
            start(this);
        });
    }
    imgs.css("cursor", "zoom-in");

    function start(i) {
        var popSrc = i.src;
        $("body").append('<div class="popImgMask" id="popImgMask"></div>');
        if (imgs.length > 1) {
            if (isMobile) {
                jsalert("左右滑动查看");
            } else {
                jsalert("左右键切换图片");
            }
        }

        function newImg(src, title) {
            $("#popImg").removeWithoutLeaking();
            $("#popImgMask").css("background-image", "url(http://www.mvcat.com/img/loading_dot.gif)");
            $("#popImgMask").prepend('<img class="popImg" id="popImg" src="' + src + '" width="0" height="0" style="cursor: zoom-out;" />');
            img = $("#popImg");
            var newImg = new Image();
            newImg.src = src;
            jsalert(title, 1e4);
            newImg.onload = function () {
                $("#popImgMask").css("background-image", "none");
                //imgResize
                var iWidth = $(window).width();
                var iHeight = $(window).height();
                var clientw = iWidth - 50;
                var clienth = iHeight - 50;
                var imgw = newImg.width;
                var imgh = newImg.height;
                if (imgw < clientw && imgh > clienth) {
                    h = clienth;
                    w = imgw * h / imgh;
                } else if (imgw > clientw && imgh < clienth) {
                    w = clientw;
                    h = imgh * w / imgw;
                } else if (imgw > clientw && imgh > clienth && imgw / imgh >= clientw / clienth) {
                    w = clientw;
                    h = imgh * w / imgw;
                } else if (imgw > clientw && imgh > clienth && imgw / imgh < clientw / clienth) {
                    h = clienth;
                    w = imgw * h / imgh;
                } else {
                    w = imgw;
                    h = imgh;
                }
                img.height(h + "px");
                img.width(w + "px");
                img.css("top", (iHeight - h) / 2 + "px");
                img.css("left", (iWidth - w) / 2 + "px");
                img.fadeOut(0).fadeIn();
                //图片颜色
                if (/mvcat.com/.test(src) && !isIE678) {
                    var vibrant = new Vibrant(newImg);
                    var swatches = vibrant.swatches();
                    var newcolor = "#eee";
                    if (swatches["Vibrant"]) {
                        newcolor = swatches["Vibrant"].getHex();
                    }
                    //img.css({'background-color':newcolor,'box-shadow':'0 0 0 8px' + newcolor});
                    $(".imgNav a").css("color", newcolor);
                }
            };
        }

        //end newImg
        $("#popImgMask").append('<div class="imgNav desktop" id="imgNav"><a class="none" href="javascript:void(0)" id="prevImg" ></a><a class="none" href="javascript:void(0)" id="nextImg" ></a></div>');
        //全局
        imgl = imgs.index($(i));

        function imgNav(n) {
            imgl = parseInt(imgl + n);
            if (imgs.length > 1) {
                $("#prevImg,#nextImg").show();


            }
            if (imgl <= 0) {
                imgl = 0;
                $("#prevImg").hide();
            }
            if (imgl >= imgs.length - 1) {
                imgl = imgs.length - 1;
                $("#nextImg").hide();
            }
            var src = imgs[imgl].src;

            var oSrc = $(imgs[imgl]).attr("data-original") || "";
            if (oSrc !== "") {

                src = oSrc;
            }
            var title = imgs[imgl].title;
            if ($(imgs[imgl]).parent(".poster").length > 0) {
                var targetOffset = $(imgs[imgl]).parent(".poster")[0].offsetTop - 20;
            } else {
                var targetOffset = imgs[imgl].offsetTop - 20;
            }
            if (targetOffset > $("body").offset().top) {
                $("html,body").animate({
                    scrollTop: targetOffset
                }, 500);
            }
            newImg(src, title);
        }

        imgNav(0);
        try {
            $("#prevImg").click(function () {
                imgNav(-1);
                //if (imgl == 0)jsalert("没有了")
                return false;
            });
            $("#nextImg").click(function () {
                imgNav(1);
                //if (imgl == imgs.length - 1)jsalert("没有了")
                return false;
            });
        } catch (err) {
        }
        $(".popImgMask").click(function () {
            $(".popImgMask,.popImg,.imgNav,.popImgStyle,.jsalert").removeWithoutLeaking();
            $(document).unbind("keydown");
            return false;
        });

        // END popImg	
        //keyevent
        $(document).unbind("keydown");
        $(document).keydown(function (event) {
            if (event.ctrlKey || event.shiftKey || event.altKey || event.metaKey || /input|textarea/.test(document.activeElement.tagName.toLowerCase())) {
                return;
            } else {
                event.preventDefault();
            }
            switch (event.keyCode) {
                case 37:
                    //左
                    $("#prevImg").click();
                    break;

                case 39:
                    //右
                    $("#nextImg").click();
                    break;

                case 38:
                    //上
                    $("#prevImg").click();
                    break;

                case 40:
                    //下
                    $("#nextImg").click();
                    break;

                case 27:
                    //esc
                    $(".popImgMask").click();
                    break;
            }
        });
        //滑动
        if ($(window).width() < 768) {
            $("#popImgMask").swipe({
                swipeLeft: function () {
                    $("#nextImg").click();
                },
                swipeRight: function () {
                    $("#prevImg").click();
                },
                excludedElements: $.fn.swipe.defaults.excludedElements + ", #xx , #xxx"
            });
        }
    }
}

//end popImg


//站内搜索 insearch

function insearch(word, type) {

    if (word == "全屏") {
        if (fullscreen) {
            exitFullScreen()
        } else {
            fullScreen()
        }
        ;
        return;
    }

    if (word == "今日") {
        if ($("#ftool .fdaily").length > 0) {
            $("#ftool .fdaily").click();
        } else {
            jsalert("今日无事！")
        }
        return;
    }

    if (word == "点点") {
        $("body").append('<script src="http://www.mvcat.com/script/game_dotline.js"></script>')
        return;
    }

    if (word == "虎鲸") {
        $("body").append('<script src="http://www.mvcat.com/script/game_whale.js"></script>')
        return;
    }

    if (word == "矩阵" || word == "matrix") {
        bgmStop();
        musicmask = false;
        bgmPlay('http://music.163.com/song/media/outer/url?id=5054972.mp3');
        bgm = true;
        $("body").append('<script src="/script/game_matrix.js"></script>').removeClass("breath sleepy nightmode").addClass('bgmask movie sf');
        $(window).trigger("resize");
        return;
    }

    if (word == "彩带") {
        evanyou('body');
        return;
    }


    if (/v.youku.com|tudou.com|iqiyi.com|v.qq.com|letv.com|le.com|mgtv.com|pptv.com|tv.sohu.com|acfun.cn|acfun.tv|bilibili.com|tv.cctv.com|m1905.com|v.yinyuetai.com|www.56.com|vlook.cn|v.ku6.com|miaopai.com|weibo.com|v.17173.com|v.ifeng.com|meipai.com|weishi.com|\.m3u8|\.mp4|#vip/.test(word)) {
        popIframe("http://www.mvcat.com/player/?url=" + word);
        return;
    }

    if (/http/.test(word)) {
        popIframe(word);
        return;
    }


    if (/吃什么/.test(word)) {
        popIframe('http://www.mvcat.com/game/eat/');
        return;
    }

    if (word == "初音") {
        popIframe('http://www.mvcat.com/game/mikutap/');
        return;
    }

    if (/壁纸/.test(word)) {
        popIframe('http://www.mvcat.com/api/image/bing.php');
        return;

    }

    if (word == "直播" || word == "电视") {
        popIframe(mvcaturl('http://live.maohaha.com/'));
        return;
    }

    if (/观看|在线/.test(word)) {
        popIframe("http://www.mvcat.com/vsearch/?type=online&word=" + word);
        return;
    }

    if (/下载|磁力|网盘/.test(word)) {
        popIframe("http://www.mvcat.com/vsearch/?type=download&word=" + word);
        return;
    }

    if (/字幕/.test(word)) {
        popIframe("http://www.mvcat.com/vsearch/?type=subtitle&word=" + word);
        return;
    }

    if ($("body").hasClass("music") || word.indexOf("音乐") == 0 || word.indexOf("音乐") == word.length - 2 || word.indexOf("歌曲") == 0 || word.indexOf("歌曲") == word.length - 2) {
        var type = type || "Title,Tags";
        popIframe("http://www.mvcat.com/music/search/?type=" + type + "&word=" + word.replace(/(音乐|音乐 | 音乐|歌曲|歌曲 | 歌曲)/g, ""));
    } else if ($("body").hasClass("wiki")) {
        var type = type || "Title,Tags";
        popIframe("http://www.mvcat.com/wiki/search/?type=" + type + "&word=" + word);
        //搜年份
    } else if (/^[0-9]+[0-9]*[0-9]*$/.test(word) && word.length == 4) {
        var type = "AddDate";
        popIframe("http://www.mvcat.com/search/?channelID=3&type=" + type + "&word=" + word);
    } else {
        var type = type || "Title,subTitle,Tags";
        //word = word.replace(/(电影|电视剧)/g,"");
        popIframe("http://www.mvcat.com/search/?type=" + type + "&word=" + word);
    }
}

//ondeydown
//document.onkeydown=function(){if (event.keyCode === 13){insearch($("#word").val())}};

//mobilesearch
//if($("body").width() <= 768 && $('body.about,body.search').length == 0 && $('body.channel .right h1,body.channel .right h2').length > 0)$('body.channel .right h1,body.channel .right h2').first().append('<form class="mobile list" style="width: 100%!important;margin: 0;padding: 2% 0;" onsubmit="insearch($(\'#mobilesearch\').val());return false;" autocomplete="off"><input id="mobilesearch" value="&#xe870;" onclick="$(this).val(\'\')" style="display: block;width: 100%;text-align: right;font-family:\'iconfont\';font-size: 24px;height: 28px;"></form>');


//电影网站
var qWatch = function (txt) {
    if (txt.length == 0) return;
    if (txt.length > 18) txt = txt.slice(0, 19);
    var q = '<fieldset class="qBox qwatch"><legend>《<span class="keyword">' + txt + '</span>》在线观看&nbsp;</legend><a href="http://www.mvcat.com/vsearch/?type=online&word=' + txt + '" rel="nofllow">影猫快搜</a><a href="http://so.iqiyi.com/so/q_' + txt + '" rel="nofllow">奇艺搜索</a><a href="https://so.360kan.com/index.php?kw=' + txt + '" rel="nofllow">360影视</a><a href="https://so.youku.com/search_video/q_' + txt + '" rel="nofllow">搜酷搜索</a></fieldset>';
    return q;
}
var qDown = function (txt) {
    if (txt.length == 0) return;
    if (txt.length > 18) txt = txt.slice(0, 19);
    var q = '<fieldset class="qBox qdown"><legend>《<span class="keyword">' + txt + '</span>》资源下载&nbsp;</legend><a href="http://www.mvcat.com/vsearch/?type=download&word=' + txt + '" rel="nofllow">影猫快搜</a><a href="https://www.baidu.com/s?wd=' + txt + '下载" rel="nofllow">搜索下载</a><a href="https://www.baidu.com/s?wd=' + txt + '网盘" rel="nofllow">搜索网盘</a><a href="https://www.baidu.com/s?wd=' + txt + '字幕" rel="nofllow">搜索字幕</a></fieldset>';
    return q;
}

var qData = function (txt) {
    if (txt.length == 0) return;
    if (txt.length > 18) txt = txt.slice(0, 19);
    var q = '<fieldset class="qBox qdata"><legend>《<span class="keyword">' + txt + '</span>》资料介绍&nbsp;</legend><a href="http://baike.baidu.com/search/word?word=' + txt + '" rel="nofllow">百度百科</a><a href="http://www.baike.com/wiki/' + txt + '" rel="nofllow">互动百科</a><a href="https://zh.wikipedia.org/wiki/' + txt + '" rel="nofllow">维基百科</a></fieldset>';
    return q;
}
var qReview = function (txt) {
    if (txt.length == 0) return;
    if (txt.length > 18) txt = txt.slice(0, 19);
    var q = '<fieldset class="qBox qreview""><legend>《<span class="keyword">' + txt + '</span>》评分影评&nbsp;</legend><a href="https://m.douban.com/search/?query=' + txt + '&type=movie" rel="nofllow">豆瓣电影</a><a href="http://search.mtime.com/search/?q=' + txt + '" rel="nofllow">时光网</a></fieldset>';
    return q;
}

var qMusic = function (txt) {
    if (txt.length == 0) return;
    if (txt.length > 18) txt = txt.slice(0, 19);
    var q = '<fieldset class="qBox qmusic"><legend>《<span class="keyword">' + txt + '</span>》 收听/下载/MV&nbsp;</legend><a href="http://music.163.com/#/search/m/?s=' + txt + '" rel="nofllow">网易云音乐</a><a href="http://www.xiami.com/search?key=' + txt + '" rel="nofllow">虾米音乐</a><a href="http://sou.kuwo.cn/ws/NSearch?key=' + txt + '" rel="nofllow">酷我音乐</a><a href="http://so.yinyuetai.com/mv?keyword=' + txt + '" rel="nofllow">音悦台</a><a href="https://m.douban.com/search/?query=' + txt + '&type=music" rel="nofllow">豆瓣音乐</a></fieldset>';
    return q;
}

//快捷搜索
var qSearchSites = function (txt) {
    var q = '<fieldset class="qBox qSearch"><legend onClick="insearch(\'' + txt + '\',\'Title\')">《' + txt + '》观看/下载&nbsp;</legend><a href="http://www.mvcat.com/vsearch/?type=online&word=' + txt + '" rel="nofllow">免费在线</a><a href="http://so.iqiyi.com/so/q_' + txt + '" rel="nofllow">正版播放</a><a href="http://www.mvcat.com/vsearch/?type=download&word=' + txt + '" rel="nofllow">下载地址</a><a href="https://m.douban.com/search/?query=' + txt + '&type=movie" rel="nofllow">豆瓣电影</a><div id="closeqBox" onclick="$(this).parent(\'.qBox\').hide();">✕</div></fieldset>';

    if ($("body").hasClass("music") || $("body").hasClass("mabc") || $("body").hasClass("mtalk")) {
        q = '<fieldset class="qBox qSearch"><legend>《<span class="keyword">' + txt + '</span>》 收听/下载/MV&nbsp;</legend><a href="http://music.163.com/#/search/m/?s=' + txt + '" rel="nofllow">网易云音乐</a><a href="http://www.xiami.com/search?key=' + txt + '" rel="nofllow">虾米音乐</a><a href="http://sou.kuwo.cn/ws/NSearch?key=' + txt + '" rel="nofllow">酷我音乐</a><a href="http://so.yinyuetai.com/mv?keyword=' + txt + '" rel="nofllow">音悦台</a><a href="https://m.douban.com/search/?query=' + txt + '&type=music" rel="nofllow">豆瓣音乐</a><div id="closeqBox" onclick="$(this).parent(\'.qBox\').hide();">✕</div></fieldset>';
    }
    ;

    return q;
}

var qSearch = function (s) {
    var txt = '';
    var selectTxt = function () {

        if (document.selection) {
            txt = document.selection.createRange().text;

        } else {
            txt = document.getSelection();

        }

        txt = txt.toString();

        if (txt.length > 18) {
            txt = txt.slice(0, 19);
        }

        return txt;

    };


    $('<div id="huaci" style="display:none;position:absolute;z-index:1;" ></div>').appendTo('body');

    $(s).mouseup(function (e) {
        if (e.target.id === 'huaci') {
            return

        }
        e = e || window.event;
        var txt = selectTxt(),
            sh = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0,
            left = (e.clientX - 40 < 0) ? e.clientX + 20 : e.clientX - 40,
            top = (e.clientY - 40 < 0) ? e.clientY + sh + 20 : e.clientY + sh - 40;
        var txt = selectTxt();

        $('#huaci').html(qSearchSites(txt));

        if (txt) {
            $('#huaci').show(300).css({
                left: left,


                top: top

            });

        } else {
            $('#huaci').hide(300);


        }

    });

    return qSearchSites(txt);

};


//download
function download() {


    if ($("#download .item").length > 0) {

        $("#download").prepend('<tr><th align="left"><h3 class="sorttitle">下载资源 <span class="sorts"><a href="#蓝光" class="sort none">蓝光</a><a href="#1080P" class="sort none">1080P</a><a href="#720P" class="sort none">720P</a><a href="#中字" class="sort none">中字</a><a href="#3D" class="sort none">3D</a></span></h3></th></tr>');

        if (title.length > 0) {

            $("#download .sorts").append('<a href="javascript:popIframe(\'http://www.zimuzu.tv/search?type=subtitle&keyword=' + title + '\')" rel="nofollow">字幕</a>');
        }


        //$("#summary tr").append('<td valign="middle" class="function download" ><a href="#download" onClick="$(\'#download,#downloadad\').show()"><span class="icon"></span><br><span class="title">下载<span class="desktop">地址</span></span></a></td>');
        //$("#ftool .icon.mplay").after('<a href="#download">下载</a>');

        //模拟点击量
        $("#download .item a").click(function () {
            $.ajax({
                url: "http://www.mvcat.com/sitefiles/services/cms/PageService.aspx?type=AddCountHits&publishmentSystemID=" + siteID + "&channelID=" + channelID + '&contentID=' + contentID + "&fileurl=/"
            });
        })


        //检测下载地址
        $("#download .item").each(function () {

            var str = $(this).text().toLowerCase();
            if (/1080p/.test(str)) {
                $(this).find(".title").prepend('<span class="blue">[1080P]</span>');
                $(this).addClass("1080p");
            }
            if (/720p/.test(str)) {
                $(this).find(".title").prepend('<span class="blue">[720P]</span>');
                $(this).addClass("720p");
            }
            if (/blu-ray|bluray/.test(str)) {
                $(this).find(".title").prepend('<span class="blue">[蓝光]</span>');
                $(this).addClass("蓝光");
            }
            if (/.avc|bd25|bd50|truehd|lpcm|ma5.1|ma.5.1/.test(str)) {
                $(this).find(".title").prepend('<span class="blue">[原画]</span>');
                $(this).addClass("原画");
            }
            if (/.3d|.mvc/.test(str)) {
                $(this).find(".title").prepend('<span class="green">[3D]</span>');
                $(this).addClass("3d");
            }
            if (/chs|中字|中英/.test(str)) {
                $(this).find(".title").prepend('<span class="green">[中字]</span>');
                $(this).addClass("中字");
            }
            if (/hdtc|tc720|tc1080|抢先版|枪版/.test(str)) {
                $(this).find(".title").prepend('<span class="red">[枪版]</span>');
                $(this).addClass("枪版");
            }
        })
        //end检测下载地址

    }

    autosort("#download");

}

//end download

//download();


//autosort

function autosort(s) {
    s = $(s);
    s.find(".item").each(function () {
        i = $(this);
        var itemsrc = $(this).text().toLowerCase();

        s.find(".sort").each(function () {
            var sortsrc = $(this).text().toLowerCase();
            if (itemsrc.indexOf(sortsrc) !== -1 || i.hasClass(sortsrc)) {
                $(this).show();
                i.addClass(sortsrc);
            }
        });
    });

    s.find(".sort").click(function () {
        var sortsrc = $(this).text().toLowerCase();


        $(this).addClass("current").siblings(".sort").removeClass("current");
        $(s).find(".item").hide();
        $(s).find(".item." + sortsrc).show();
    })
}

autosort(".autosort");
//end autosort


//tooltip
$.fn.extend({
    tooltip: function () {
        if (isMobile) return;
        var targets = this, target = false, tip = false, tooltip = false, title = false;
        targets.not(".tooltiped").bind("mouseenter", function () {
            target = $(this);
            tip = target.attr("title");
            tooltip = $('<div id="tooltip"></div>');
            if (!tip || tip == "") return;
            target.removeAttr("title");
            tooltip.css("opacity", 0).html(tip).appendTo("body");
            var init_tooltip = function () {

                if ($(window).width() < tooltip.outerWidth() * 1.5) tooltip.css("max-width", $(window).width() / 2); else tooltip.css("max-width", 240);

                var pos_left = target.offset().left + target.outerWidth() / 2 - tooltip.outerWidth() / 2,
                    pos_top = target.offset().top - tooltip.outerHeight() - 20;
                if (pos_left < 0) {
                    pos_left = target.offset().left + target.outerWidth() / 2 - 20;
                    tooltip.addClass("tleft");
                } else tooltip.removeClass("tleft");
                if (pos_left + tooltip.outerWidth() > $(window).width()) {
                    pos_left = target.offset().left - tooltip.outerWidth() + target.outerWidth() / 2 + 20;
                    tooltip.addClass("tright");
                } else tooltip.removeClass("tright");
                if (pos_top < 0) {
                    var pos_top = target.offset().top + target.outerHeight();
                    tooltip.addClass("ttop");
                } else tooltip.removeClass("ttop");
                tooltip.css({
                    left: pos_left,

                    top: pos_top
                }).animate({
                    top: "+=10",
                    opacity: 1
                }, 150);
            };
            init_tooltip();
            //$(window).resize(init_tooltip);
            target.addClass("tooltiped");
            var remove_tooltip = function () {
                target.attr("title", tip);
                $("#tooltip").removeWithoutLeaking();
                //$(window).resize(init_tooltip);
            };
            target.bind("mouseleave", remove_tooltip);
            tooltip.bind("click", remove_tooltip);
            //$(document).bind("scroll", remove_tooltip);
        });
    }
});
//end tooltip


//breath 弃用
function breath(s) {
    breathInt = setInterval(function () {
        $(s).animate({
            opacity: "0.1"
        }, 1800).animate({
            opacity: "1"
        }, 2800);
    }, 800);
}

// 气泡 particles bubble
function bubble(selector, num, size, color, direction, speed, callback) {

    if ($("body.music").length == 0) return;

    $(selector).attr("id", "particles-js");

    particlesJS("particles-js", {
        "particles": {
            "number": {
                "value": num || 48,
                "density": {
                    "enable": true,
                    "value_area": 800
                }
            },
            "color": {
                "value": color || "#ffffff"
            },
            "shape": {
                "type": "circle",
                "stroke": {
                    "width": 0,
                    "color": "#000000"
                },
                "polygon": {
                    "nb_sides": 5
                },
                "image": {
                    "src": "img/github.svg",
                    "width": 100,
                    "height": 100
                }
            },
            "opacity": {
                "value": 0.5,
                "random": true,
                "anim": {
                    "enable": false,
                    "speed": 1,
                    "opacity_min": 0.1,
                    "sync": false
                }
            },
            "size": {
                "value": size || 10,
                "random": true,
                "anim": {
                    "enable": false,
                    "speed": 40,
                    "size_min": 0.1,
                    "sync": false
                }
            },
            "line_linked": {
                "enable": false,
                "distance": 500,
                "color": color || "#ffffff",
                "opacity": 0.4,
                "width": 2
            },
            "move": {
                "enable": true,

                "speed": speed || 6,
                "direction": direction || "bottom",
                "random": false,
                "straight": false,

                "out_mode": "out",
                "bounce": false,
                "attract": {
                    "enable": false,
                    "rotateX": 600,
                    "rotateY": 1200
                }
            }
        },
        "interactivity": {
            "detect_on": "window",
            "events": {
                "onhover": {
                    "enable": true,
                    "mode": "bubble"
                },
                "onclick": {

                    "enable": true,
                    "mode": "repulse"
                },
                "resize": true
            },
            "modes": {
                "grab": {
                    "distance": 400,
                    "line_linked": {
                        "opacity": 0.5
                    }
                },
                "bubble": {
                    "distance": 400,
                    "size": size / 2 || 4,
                    "duration": 0.3,
                    "opacity": 1,
                    "speed": 3
                },
                "repulse": {
                    "distance": $(selector).width() / 4,
                    "duration": 0.1
                },
                "push": {
                    "particles_nb": 4
                },
                "remove": {
                    "particles_nb": 2
                }
            }
        },
        "retina_detect": true
    })
    $(selector + " .particles-js-canvas-el").animate({
        opacity: '1'
    }, 1500) //.addClass("layer").attr("data-depth","0.2");
} //end bubble

//bgmask
var musicmask = false;
if (getCookie("musicmask") == "on" || $("body.root,body.music.content").length > 0) {
    musicmask = true;
}
var musicmasksrc = "";

function musicmasker() {
    if (!musicmask) return;
    try {
        tempImg.onload = null;
    } catch (err) {
    }
    ; //中止未完成
    if ($("body.root.swipeLeft").length > 0) $("body").addClass("loading bgmask musicmask");
    $(window).trigger("resize");
    tempImg = new Image();
    tempImg.src = musicmasksrc;
    tempImg.onload = function (e) {

        //if (bgm == false) return;

        $("body").prepend('<div class="bgmask musicmask" style="display:none;"><div class="bgmask layer shine" data-depth="0.4" style="background-image:url(\'' + encodeURI(musicmasksrc) + '\');"></div></div>');

        //ripples
        if ($(".music.root").length > 0) {
            if (nightmode) {
                stars("div.musicmask .layer", 300, 3);
                counter++;
                //$("canvas#stars").addClass("layer").attr("data-depth","0.4");
            } else {
                if (!isMobile) {
                    $("div.musicmask .layer").ripples();
                    counter++;
                }


            }

        }

        //parallax 分开写
        //if ($("body.root.swipeLeft,body.music").length > 0) {

        $('div.musicmask').addClass("parallax");

        //}
        if (!isIE678) {
            var vibrant = new Vibrant(tempImg);
            var swatches = vibrant.swatches();
            if (swatches['LightVibrant'] && $("body.channel.movie").length == 0) {
                swatchelor = swatches['LightVibrant'].getHex();
                if ($("#tempcss").length == 0) {
                    $("body").append('<style id="tempcss"></style>')
                }
                ;
                $("#tempcss").html('*,*:before,*:after,body.bgmask *,body.nightmode *, body.nightmode *:before, body.nightmode *:after,body.nightmode:after{color: ' + swatchescolor + '!important;}#closemask:after{color: ' + autoTextColor(swatchescolor) + '!important;}');

                //均衡器
                if (!isMobile && $("body").height() >= 300 && $("audio#aplayer,body.music").length > 1 && /mvcat.com/.test($("audio#aplayer").attr("src"))) {

                    try {
                        visualizer(themecolor);
                    } catch (err) {
                    }
                    ;
                }

            } else {
                if ($("#tempcss").length > 0) {
                    $("#tempcss").removeWithoutLeaking();
                }
                ;
            }
            $("body").addClass("bgmask musicmask");
            $("div.musicmask").fadeIn(2500, function () {
                $("body").removeClass("loading");
                //parallax & particles
                if ($("div.musicmask.parallax").length > 0) {

                    if (!isIE && !isEdge) $('div.musicmask').parallax().parallax('updateLayers'); //影响ie/edge blur

                    if ($("body").is(".sorrow")) {
                        if ($("body.content").length > 0) {
                            $.getScript("http://www.mvcat.com/script/threeSnow.js", function () {
                                threeSnow("div.musicmask", "http://www.mvcat.com/img/snow.png", 100);
                            });
                        }
                    } else if ($("body").is(".fear,.hate")) {
                        //if(!isMobile){
                        $.getScript("http://www.mvcat.com/script/threeSmoke.js", function () {
                            bloodsmoke('body');
                        });
                        //}
                    } else if ($("body").is(".love,.word")) {
                        if ($("body.content").length > 0) {
                            $.getScript("http://www.mvcat.com/script/threeSnow.js", function () {
                                threeSnow("div.musicmask", "http://www.mvcat.com/img/seed.png", 50);
                            });
                        }
                    } else {
                        if ($("body.content").length > 0) bubble("div.musicmask", 48, 24, themecolor, "top", 2);
                    }
                } else {
                    //bubble("div.musicmask",24,48,themecolor,"top",1);
                }

                //jshaker
                if ($("#mplay").hasClass("anger")) {
                    $("div.musicmask.musicmask .bgmask").addClass("jshaker").jshaker();
                    $("div.musicmask.musicmask").addClass("cshaker shake-opacity shake-constant");
                    $(".left,.showleft,#ftool,.rightside,#favorite").addClass("cshaker shake-opacity shake-constant");
                    $(".right").addClass("cshaker shake-little shake-constant");
                    startPeristentVibrate([100, 30, 100, 30, 100, 200, 200, 30, 200, 30, 200, 200, 100, 30, 100, 30, 100], 4000);
                }

                musicmask = true;
                acontrol();


            }); //end bgmask fadein

            $(window).trigger("resize");

        }//end onload

    }
}

function visualizer(color) {
    $("div.musicmask").append('<canvas id="visualizer" width="' + document.documentElement.clientWidth + '" height="' + document.documentElement.clientHeight + '" style="position:fixed;left:0;bottom:0;opacity:0.25;"></canvas>');

    window.AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext;

    var audio = document.getElementById('aplayer');
    audio.crossOrigin = 'anonymous';
    var ctx = new AudioContext();
    var analyser = ctx.createAnalyser();
    var source = ctx.createMediaElementSource(audio);
    // we have to connect the MediaElementSource with the analyser 
    source.connect(analyser);
    analyser.connect(ctx.destination);
    // we could configure the analyser: e.g. analyser.fftSize (for further infos read the spec)
    // analyser.fftSize = 64;
    // frequencyBinCount tells you how many values you'll receive from the analyser
    var frequencyData = new Uint8Array(analyser.frequencyBinCount);

    // we're ready to receive some data!
    var canvas = document.getElementById('visualizer'),
        cwidth = canvas.width,
        cheight = canvas.height - 2,
        meterWidth = 18, //width of the meters in the spectrum
        gap = 2, //gap between meters
        capHeight = 2,
        capStyle = color || '#fff',
        meterNum = cwidth / (meterWidth + 1), //count of the meters
        capYPositionArray = []; ////store the vertical position of hte caps for the preivous frame
    ctx = canvas.getContext('2d'),
        gradient = ctx.createLinearGradient(0, 0, 0, 300);
    gradient.addColorStop(1, color || '#0f0');
    gradient.addColorStop(0.5, color || '#ff0');

    gradient.addColorStop(0, '#f00');

    // loop
    function renderFrame() {
        var array = new Uint8Array(analyser.frequencyBinCount);
        analyser.getByteFrequencyData(array);
        var step = Math.round(array.length / meterNum); //sample limited data from the total array
        ctx.clearRect(0, 0, cwidth, cheight);
        for (var i = 0; i < meterNum; i++) {
            var value = array[i * step];
            if (capYPositionArray.length < Math.round(meterNum)) {
                capYPositionArray.push(value);
            }
            ;
            ctx.fillStyle = capStyle;
            //draw the cap, with transition effect
            if (value < capYPositionArray[i]) {
                ctx.fillRect(i * (meterWidth + gap), cheight - (--capYPositionArray[i]), meterWidth, capHeight);
            } else {
                ctx.fillRect(i * (meterWidth + gap), cheight - value, meterWidth, capHeight);
                capYPositionArray[i] = value;
            }
            ;
            ctx.fillStyle = gradient; //set the filllStyle to gradient for a better look
            ctx.fillRect(i * (meterWidth + gap), cheight - value + capHeight, meterWidth, cheight); //the meter
        }
        requestAnimationFrame(renderFrame);
    }

    renderFrame();
    audio.play();
}

//bgm//////////////////////////////////////////////////////////////

$("#lcontrol").prepend('<div class="poster cover" id="mplay"></div><div class="acontrol none"></div>');
//musicbg
//if(!isMobile)
$(".acontrol").append('<input type="checkbox" id="musicbg" class="checkbox-ios musicbg" /><label class="musicbg tooltip" title2="快捷键 B" for="musicbg" onclick="togglemusicmask()"></label>');
//cyclemode
$(".acontrol").append('<input type="checkbox" id="cyclemode" class="checkbox-ios cyclemode" /><label class="cyclemode tooltip" title2="快捷键 S" for="cyclemode" onclick="togglecyclemode()"></label>');

function acontrol() {
    $(".acontrol").show();
    if (musicmask) {
        $("#musicbg").prop("checked", true)
    } else {
        $("#musicbg").prop("checked", false)
    }
    ;
    if (cyclemode == "single") {
        singlemode();
        $("#cyclemode").prop("checked", true);
    } else {
        randmode();
        $("#cyclemode").prop("checked", false);
    }
    ;
}

//audioAutoPlay
function audioAutoPlay(e) {
    if ($("audio").length == 0) return;
    e.play();
    if (e.paused) {
        $("body").addClass("pause");
    } else {
        $("body").removeClass("pause");
        bgm = true;
    }

    // 自动播放音乐效果，解决浏览器或者APP自动播放问题

    function musicInBrowserHandler() {

        e.play();

        $("body").removeClass("pause");

        bgm = true;
        document.body.removeEventListener('touchstart', musicInBrowserHandler);
    }

    //document.body.addEventListener('touchstart', musicInBrowserHandler);


    // 自动播放音乐效果，解决微信自动播放问题

    function musicInWeixinHandler() {
        e.play();
        document.addEventListener("WeixinJSBridgeReady", function () {
            e.play();
        }, false);
        $("body").removeClass("pause");
        bgm = true;
        document.removeEventListener('DOMContentLoaded', musicInWeixinHandler);
    }

    document.addEventListener('DOMContentLoaded', musicInWeixinHandler);

    musicmasker();
} //end audioAutoPlay

// auto volume
function autovol(vol, tip) {
    try {
        $("#aplayer")[0].volume = vol;
    } catch (err) {
    }
    ;
    //jsalert(tip + "：" + Math.round(vol*100) + "%" );
}


//bgmplay

var bgm = false;
var playtime = 0;
var mediaUrl = "", mediaCate = "", mediaTitle = "", mediaCover = "", mediaPic = "", mediaSummary = "",
    mediaLinkUrl = "";

function bgmPlay(e) {

    bgmStop("bgmplay");

    playtime = new Date().getTime();
    saveCookie("playtime", playtime);

    if (e instanceof jQuery) {
        //jquery ele
        mediaUrl = e.attr("data-media") || "";
        mediaCate = e.attr("data-cate") || e.attr("cate") || "";
        mediaTitle = e.attr("data-title") || e.attr("title") || "";
        mediaCover = e.attr("data-cover") || "";
        mediaPic = e.attr("data-pic") || "";
        mediaSummary = e.attr("data-summary") || e.attr("title") || "";
        mediaLinkUrl = e.attr("data-url") || mediaUrl;

        $("#mplay").attr("data-title", mediaTitle);
        $("#mplay").attr("data-media", mediaUrl);
        $("#mplay").attr("data-cover", mediaCover);
        $("#mplay").attr("data-pic", mediaPic);
        $("#mplay").attr("data-cate", mediaCate);
        $("#mplay").attr("data-summary", mediaSummary);
        $("#mplay").attr("data-url", mediaLinkUrl);
        $("#mplay").css("background-image", "url(" + mediaCover + ")");
        $("#mplay,body").removeClass("joy anger sorrow happy fear love hate lust poem prose motto toplist playlist").addClass(mediaCate);

        //start
        $("#mplay,.cover[data-media='" + mediaUrl + "']").addClass("playing rotate360");

        //auto scroll
        if (!isMobile) try {
            var targetOffset = $(".playing").not("#mplay").offset().top;
            //$("html,body").animate({scrollTop:targetOffset-30}, 500);
        } catch (err) {
        }
        // jquery ele
    } else {
        mediaUrl = e;
        mediaCover = "Title";
        $("#mplay,.cover[data-media='" + mediaUrl + "']").css({
            "background-image": "none",
            "background-color": "black"
        }).addClass("playing rotate360");
    }

    //音频播放器
    function aplayer(src) {

        if (!!(document.createElement('audio').canPlayType)) {

            $("body").append('<audio src="' + src + '" data-media="' + mediaUrl + '" hidden="true" height="0" width="0" preload="auto" loop="loop" class="aplayer" id="aplayer"></audio>');
        } else {
            $("body").append('<embed src="' + src + '" data-media="' + mediaUrl + '" width="0" height="0" hidden="true" loop="true" class="aplayer" id="aplayer"></embed>');
        }

        //acontrol
        acontrol();
        autonext($("#aplayer")[0]);

    }

    //.mp3

    if (/.mp3|.aac|.ogg|.wav/.test(mediaUrl.toLowerCase())) {

        aplayer(mediaUrl);
    }

    //163song
    else if (mediaUrl.indexOf("music.163.com") !== -1 && mediaUrl.indexOf("/song?") !== -1) {
        var id = mediaUrl.split("id=")[1];
        aplayer("http://music.163.com/song/media/outer/url?id=" + id + ".mp3");

    }

    //end 163song

    //163playlist album
    else if (mediaUrl.indexOf("music.163.com") !== -1) {
        if (mediaUrl.indexOf("/playlist?") !== -1 || mediaUrl.indexOf("/toplist?") !== -1) {
            var type = 0;
        }
        if (mediaUrl.indexOf("/album?") !== -1) {
            var type = 1;
        }
        var id = mediaUrl.split("id=")[1];
        if ($("#content").length > 0) {
            var playlist = '<p id="aplayer" class="aplayer" style="background:rgba(0,0,0,0.05) url(\'' + mediaCover + '\') no-repeat center center;background-size: cover;box-shadow2: 0px 10px 50px -15px #000;"><iframe id="aplayer" class="aplayer"  style="background:rgba(0,0,0,0.05) url(http://www.mvcat.com/img/loading_dot.gif) no-repeat center center;opacity:0.85;" frameborder="0" width="330" height="450" src="http://music.163.com/outchain/player?type=' + type + '&auto=1&height=430&id=' + id + '"></iframe></p>';
            $("#content").before(playlist);
        } else {
            $("body").after('<iframe class="mplayer none" frameborder="0" width="330" height="450" src="http://music.163.com/outchain/player?type=' + type + '&auto=1&height=430&id=' + id + '"></iframe>');
        } // end #content
        //acontrol

        acontrol();


    } //end 163playlist album


    //load


    $(".aplayer").on("load play", function () {

        try {
            acycle($("#aplayer"), $(".cover.playing"));
        } catch (err) {
        }

    })
    //end load

    //autovol
    var cvol = getCookie("volume");
    if ($("body.content.word").length > 0) {
        autovol("0.3", "自动音量")
    } else if ($("#aplayer").length > 0 && cvol != null) {
        autovol(cvol, "记忆音量");
    }


    //bgmask musicmask

    musicmasksrc = mediaCover;
    if (mediaPic.length != 0 && isImgUrl(mediaPic)) {
        musicmasksrc = mediaPic;
        console.log(mediaPic);
    }

    //music download
    //if($("body.content.music.song").length>0 && $("#author").length>0){
    //$("#author").append('<p><a href="javascript:popIframe(mvcaturl(\'' + videourl + '\'))">♫ 下载</a></p>')
    //}


    //开始播放
    audioAutoPlay($("#aplayer")[0]);


    //音乐记录
    if ($("body.music").length > 0) {
        favtitle = mediaTitle;
        favurl = mediaLinkUrl.split("#")[0].split("http://www.mvcat.com")[1];
    }

} // end bgmPlay

//bgmPause
function bgmPause() {
    if (bgm) {
        if ($("body.music").length == 0 || $("body.anger,.jshaker,.cshaker").length > 0) { //不适合暂停音乐的场景
            bgmStop();
            return;
        }
        try {
            $("audio")[0].pause();
        } catch (err) {
            bgmStop();
            return;
        }
        $("body").addClass("pause");
        $(".playing").removeClass("rotate360");
        bgm = false;
    } else {
        try {
            $("audio")[0].play();
        } catch (err) {
            bgmPlay($("#mplay"));
            return;
        }
        ;
        if ($("body.pause").length == 0) musicmasker();
        $("body").removeClass("pause");
        $(".playing").addClass("rotate360");
        bgm = true;
    }
} //end bgmPause

//bgmStop
function bgmStop(e) {
    //remove css
    $("body").removeClass("loading bgm pause");
    $("#mplay,#cover,body").removeClass("action war sf suspense comedy love spirit cartoon horror crime erotic documentary drama cult joy anger sorrow happy fear love hate lust poem prose motto toplist playlist");
    $(".playing").removeClass("playing rotate360");
    //remove bgmask
    try {
        if (e != "bgmplay") $("body.bgmask").removeClass("bgmask musicmask");//连续播放无需更改
        if ($("#tempcss").length > 0 && e != "bgmplay") { //bgmplay无需更改css
            $("#tempcss").removeWithoutLeaking();
        }
        ;
        $("body .musicmask").stop(true, false).fadeOut(1500, function (e) {
            $(this).removeWithoutLeaking();
        });
    } catch (err) {
    }
    ;

    if ($(".jshaker").length > 0) {
        try {
            $(".jshaker").stop(true, false).find("*").stop(true, false);
        } catch (err) {
        }
        ;
    }
    if ($(".cshaker").length > 0) {
        try {
            $(".cshaker").removeClass("shake shake-little shake-slow shake-fast shake-opacity shake-crazy shake-chunk");
        } catch (err) {
        }
        ;
    }

    stopVibrate();

    try {
        $("audio").each(function () {
            $(this)[0].stop();
        })
    } catch (err) {
    }
    try {
        $("audio,.aplayer,.acycle,#bloodsmoke,#vertexShader,#fragmentShader,#matrix,#whale,#dotlaine,#evanyou").removeWithoutLeaking();
    } catch (err) {
    }

    $(".acontrol").hide();
    $(window).trigger("resize"); //还原颜色

    bgm = false;


} //end bgmStop


//acycle
function acycle(audio, e) {
    if (audio.length == 0 || e.length == 0) return;
    var aplayer = audio[0];
    $(".acycle").removeWithoutLeaking();
    e.append('<canvas class="acycle mplayer"></canvas>');

    //绑定timeupdate事件
    aplayer.addEventListener('timeupdate', function () {
        if (!isNaN(aplayer.duration)) {
            var progressValue = aplayer.currentTime / aplayer.duration; //用时间比来获取进度条的值
            if (progressValue == 1) {
                progressValue = 0; //当播放完成，进度条跳到开始
            }

            if ($('.acycle').length > 0) {
                drawCircle(progressValue, $('.acycle'));
            }
        }
    }, false);


    drawCircle = function (percentage, canvas) {

        canvas.each(function () {


            var canvas = $(this)[0];
            var lineWidth = 8;

            var canvasWidth = $(this).parent().width();
            var innerR = canvasWidth / 2 - lineWidth / 2; //半径
            if ($(window).width() < 991) {
                innerR = canvasWidth / 2 - lineWidth / 4;
            }
            var ctx;
            canvas.setAttribute('width', canvasWidth + 'px');
            canvas.setAttribute('height', canvasWidth + 'px');
            if (canvas.getContext) {
                ctx = canvas.getContext('2d');
            }
            ctx.translate(canvasWidth / 2, canvasWidth / 2);
            ctx.beginPath();
            ctx.arc(0, 0, innerR, 0, (Math.PI * 2 / 180 + percentage * Math.PI * 2), false);
            ctx.lineWidth = lineWidth;
            if ($(window).width() < 991) {

                ctx.lineWidth = lineWidth / 2;
            }
            ctx.fillStyle = themecolor;
            ctx.strokeStyle = themecolor;
            ctx.stroke();
            if (window.devicePixelRatio) ctx.scale(window.devicePixelRatio, window.devicePixelRatio);
        });

    };


}

//end acycle

function checkmovieurl() {

//视频字段videourl检测
    if (/.mp4/.test(videourl)) {
        loadVideo($("#content"), videourl, imageurl);
    } else if (/http:|https:/.test(videourl) && videourl.indexOf("music.163.com") == -1) {
        $("#content").prepend('<iframe class="media" src="' + videourl + '" frameborder=0 allowfullscreen="true" allowtransparency="true"></iframe>');
    } else if (/thunder:|ed2k:|magnet|.torrent/.test(videourl)) {
        $("#content").append('<h2>下载地址</h2><blockquote><a href="?' + videourl + '" rel="nofollow">' + videourl + '</a></blockquote>');
    }
// end 视频地址videourl

//fileurl
//download resource
    if (/thunder:|ed2k:|magnet|.torrent/.test(fileurl)) {
        $("#content").append('<h2>下载地址</h2><blockquote><a href="' + fileurl + '" rel="nofollow">' + fileurl + "</a></blockquote>");
    } else if (/jd.com/.test(fileurl)) {
        $("#summary tr").append('<td valign="middle" class="function disc" ><a href="' + fileurl + '" target="_blank" rel="nofollow"><span class="icon"></span><br /><span class="title"><span class="desktop">正版</span>光盘</span></a></td>');
    } else {

    }
//end fileurl

// download count
    if ($(".function.download,.function.disc,.function.magnet").length > 0) {
        $(".function.download,.function.disc,.function.magnet").click(function () {
            $.ajax({
                url: "http://www.mvcat.com/sitefiles/services/cms/utils.aspx?type=Download&publishmentSystemID=" + siteID + "&channelID=" + channelID + '&contentID=' + contentID + "&fileurl=/"
            });
        })
    }

}//end checkmovieurl


//京东搜索
function jdsearch(key) {
    var clickUrl = "//union-click.jd.com/jdc?type=union&p=AhoHUhhZFgUbAmUfaxQyEzcRRANLXUlFZUIeUEMZGUtdHVMdSVJKSQVJMhpVXR9bHAEbU11MDxALFw9dHghFBxpXUxhdRwYSAQFLa0pGT1plG1oUAhABVBJdHDIiZicrayUyIjdUK2slMg==&t=W1dCFBBFC0RUQUpADgpQTFs=&e=&tu=#targetUrl";
    var keyUrl = 'http://search.jd.com/Search?keyword=' + key
        + '&enc=utf-8';
    keyUrl = clickUrl.replace("#targetUrl", encodeURIComponent(keyUrl));
    window.open(keyUrl);
}

//电影 全网资源
function allsearch(title) {
    var title = title.split(" ")[0];
    if ($("body.movie.content h1,body.timeline.content h1,body.search h1").length > 0) {
        if ($("#qlink").length == 0) $(".right h1").first().after('<div class="全网搜索 clear none" id="qlink"></div>');
        $("#qlink").html(qWatch(title) + qDown(title) + qData(title) + qReview(title));
        $("#qlink .tooltip").tooltip();
        $(".right h1").first().addClass("allsearch").unbind("click").click(function () {
            $("#qlink").slideToggle(300);
        });
        if ($(".function.play.search,.function.ticket").length == 0) $("#summary tr").append('<td class="function search play tooltip" title="' + jumptip + '"><a href="http://www.mvcat.com/vsearch/?type=online&word=' + title + '" rel="nofollow" ><span class="icon"></span><br /><span class="title">免费<span class="desktop">观看</span></span></a></td>');
        if ($(".function.download.search,.function.ticket").length == 0) $("#summary tr").append('<td valign="middle" class="function search download tooltip" title="' + jumptip + '"><a href="http://www.mvcat.com/vsearch/?type=download&word=' + title + '"><span class="icon"></span><br><span class="title"><span class="desktop">搜索</span>下载</span></a></td>');
        if ($(".function.music").length == 0 && !/music.163.com/.test(subtitle)) $("#summary tr").append('<td class="function music desktop"><a href="http://music.163.com/#/search/m/?type=10&s=' + title + '"><span class="icon"></span><br /><span class="title">原声<span class="desktop">搜索</span></span></a></td>');
        if ($(".function.disc").length == 0) $("#summary tr").append('<td valign="middle" class="function disc" ><a href="javascript:jdsearch(\'' + title + '\')" target="_blank"  rel="nofollow"><span class="icon"></span><br /><span class="title"><span class="desktop">书籍</span>光盘</span></a></td>');
        if ($(".function.toy").length == 0) $("#summary tr").append('<td valign="middle" class="function toy" ><a href="javascript:jdsearch(\'' + title + '周边\')" target="_blank"  rel="nofollow"><span class="icon"></span><br /><span class="title"><span class="desktop">电影</span>周边</span></a></td>');
        if ($(".function.allsearch").length == 0) $("#summary tr").append('<td valign="middle" class="function search allsearch"><a href="javascript:$(\'#qlink\').slideToggle(300);"><span class="icon"></span><br><span class="title">全网<span class="desktop">资源</span></span></a></td>');
    }
}

//end 全网搜索

function movieinfo(data, durl) {
    if ($("table#summary,.summary.copyright,.doubansummary").length > 0) {
        $("table#summary,.summary.copyright,.doubansummary").removeWithoutLeaking();
    }

    if ($("#content").length == 0) $(".right h1").first().after('<div class="douban" id="content"></div>');

    $(".right h1").first().after('<p class="douban summary copyright" style="text-align: right;opacity: 0.5;font-size: 0.5em;margin-top: 0;"></p><table width="100%" border="0" cellpadding="8" cellspacing="0" class="douban functions" id="summary"><tbody><tr><td class="function poster" id="poster"></td><td class="info"></td></tr></tbody></table>');
    $("html,body").animate({scrollTop: 0}, "middle");
    if (data.schedule_url.length > 0 && data.year == year) {
        $('#summary .info').after('<td valign="middle" class="function ticket maoyan" ><a href="http://maoyan.com/films/" target="_blank" rel="nofollow"><span class="icon"></span><br /><span class="title">购票<span class="desktop">观看</span></span></a></td>');
        var ctip = '声明：以下数据由豆瓣API提供，请支持正版购票观看。';
    } else {
        var ctip = '声明：以下数据由豆瓣API提供，观看下载将跳转第三方网站。';
    }
    $(".summary.copyright").html(ctip);
    //海报
    $("#summary #poster").css("background-image", "url(https://images.weserv.nl/?url=" + data.images.large + ")").html('<img src="https://images.weserv.nl/?url=' + data.images.large + '" data-original="https://images.weserv.nl/?url=' + data.images.large + '" />');
    //观看
    for (var i = 0; i < Math.min(data.videos.length, 5); i++) {
        $('#summary .info').after('<td class="function play ' + data.videos[i].source.literal + ' tooltip" title="跳转 [' + data.videos[i].source.name + '] 观看"><a href="' + data.videos[i].sample_link + '" rel="nofollow" ><span class="icon"></span><br /><span class="title">' + data.videos[i].source.name.split("电影")[0].split("视频")[0] + '</span></a></td>');
    }
    //评分
    if (data.rating.average > 0) {
        $('#summary .info').after('<td valign="middle" class="function rating douban" ><a href="' + durl + '/comments" target="_blank" rel="nofollow"><span class="icon">' + data.rating.average + '</span><br /><span class="title"><span class="desktop">豆瓣</span>短评</span></a></td>');
    }
    //演员
    if ($("#summary").width() > 800) {
        if ($("#summary .casts").length > 0) $("#summary .casts").remove();
        for (var i = Math.min(data.casts.length, 3) - 1; i >= 0; i--) {
            if (data.casts[i].avatars == undefined) continue;//无头像
            $('#summary .info').after('<td valign="middle" class="poster function casts desktop" style="background-image:url(https://images.weserv.nl/?url=' + data.casts[i].avatars.large + ')"><img width="100%" src="https://images.weserv.nl/?url=' + data.casts[i].avatars.large + '" data-original="https://images.weserv.nl/?url=' + data.casts[i].avatars.large + '" class="tooltip" title="' + data.casts[i].name + '"/></td>');
        }
    }

    //内容自动隐藏
    //if($("#content").html().length<500){
    //$("#content").hide();
    //$("#content").before('<a href="#content" class="showcontent" style="display:block;margin:1em;text-align:center;text-decoration:underline;cursor:pointer;">详细资料 ▾</a>');
    //$("#content").after('<div class="qlink none"><a href="#content" class="showqlink" style="display:block;margin:1em;text-align:center;text-decoration:underline;cursor:pointer;">更多资源 ▾</a>'+qWatch(title)+qDown(title)+qData(title)+qReview(title)+'</div>');
    //$(".showcontent").click(function(){$("#content,.qlink").slideToggle(0);})
    //}else{}
    //if(videourl.length>0 && fileurl.length>0){$(".info").hide();}
    //国语电影检测
    //try{
    //if(unescape(data.countries).indexOf("中国")!==-1){
    //$(".function.subtitles").removeWithoutLeaking();}
    //}catch(e){};

    //原名
    var original_title = '';
    if (data.original_title != '') {
        original_title = ' <a class="link" href="http://www.mvcat.com/vsearch/?type=download&word=' + data.original_title + '">' + data.original_title + '</a>';
    }

    $('#summary .info').prepend('<strong>片名：</strong>' + data.title + original_title);

    //别名
    var aka = "";
    for (var i = 0; i < Math.min(data.aka.length, 5); i++) {
        aka += '<a class="link" href="http://www.mvcat.com/vsearch/?type=online&word=' + data.aka[i] + '">' + data.aka[i] + '</a> ';
    }
    if (aka != "") {
        $('#summary .info').append('<br /><strong>别名：</strong>' + aka);
    }

    //上映
    var pubdates = "";
    for (var i = 0; i < Math.min(data.pubdates.length, 5); i++) {
        pubdates += data.pubdates[i] + ' ';
    }
    if (pubdates != "") {
        $('#summary .info').append('<br /><strong>上映：</strong>' + pubdates);
    }

    if (data.durations != "") $('#summary .info').append("<br /><strong>时长：</strong>" + data.durations);
    if (data.genres != "") $('#summary .info').append("<br /><strong>类别：</strong>" + data.genres);
    if (data.countries != "") $('#summary .info').append("<br /><strong>地区：</strong>" + data.countries);

    //导演
    var directors = "";
    for (var i = 0; i < Math.min(data.directors.length, 5); i++) {
        if (data.directors[i] == undefined) continue;
        directors += '<a class="link" href="http://www.mvcat.com/search/?type=Tags&word=' + data.directors[i].name + '">' + data.directors[i].name + '</a> ';
    }
    if (directors != "") {
        $('#summary .info').append("<br /><strong>导演：</strong>" + directors);
    }
    //演员
    var casts = "";
    for (var i = 0; i < Math.min(data.casts.length, 5); i++) {
        if (data.casts[i].name == undefined) continue;
        casts += '<a class="link" href="http://www.mvcat.com/search/?type=Tags&word=' + data.casts[i].name + '">' + data.casts[i].name + '</a> ';
    }
    if (casts != "") {
        $('#summary .info').append('<br /><strong>演员：</strong>' + casts);
    }
    if (data.summary != null) {
        $("#summary").after('<p class="douban doubansummary" style="font-size:12px;"><strong>剧情：</strong>' + data.summary + "</p>");
    }
    $('#summary .info').append('<br /><strong>图集：</strong><a href="' + durl + '/photos?type=S" target="_blank" rel="nofollow">剧照</a> <a href="' + durl + '/photos?type=R" target="_blank" rel="nofollow">海报</a> <a href="' + durl + '/photos?type=W" target="_blank" rel="nofollow">壁纸</a>');
    $(".doubansummary").prepend('<span class="mobile">' + $('#summary .info').html() + "<br /></span>");
    if (data.tags != "" && $('.rightside .tags').length > 0) {
        for (var i = 0; i < data.tags.length; i++) {
            $('.rightside .tags').prepend('<a class="tag" href="http://www.mvcat.com/search/?type=Tags,Title,subTitle&word=' + data.tags[i] + '">+ ' + data.tags[i] + '</a>');
        }
    }
    //评论
    try {
        $("#content .doubancomment").removeWithoutLeaking();
    } catch (e) {
    }
    //console.log(data.popular_reviews);
    for (var i = 0; i < Math.min(data.popular_reviews.length, 5); i++) {
        if (data.popular_reviews[i] == undefined) continue;
        $("#content").first().prepend('<blockquote class="douban doubancomment popular_reviews"><span style="font-weight:bold!important;">' + data.popular_reviews[i].author.name + '：</span>' + data.popular_reviews[i].summary + ' —— 影评<a href="' + data.popular_reviews[i].alt + '">《' + data.popular_reviews[i].title + '》</a></blockquote>');
    }
    //console.log(data.popular_comments);
    for (var i = 0; i < Math.min(data.popular_comments.length, 5); i++) {
        if (data.popular_comments[i] == undefined) continue;
        $("#content").first().prepend('<blockquote class="douban doubancomment popular_comments"><span style="font-weight:bold!important;">' + data.popular_comments[i].author.name + '：</span>' + data.popular_comments[i].content + '</blockquote>');
    }

    //去除过多单元格
    try {
        setInterval(function () {
            if ($("#summary").width() > $("#summary").parent().width()) {
                $("#summary .function").not(".allsearch,.function.search").last().removeWithoutLeaking();
            }
        }, 10)
        if ($("#summary .function").length > 12) {
            //$("body").addClass("swipeLeft");
        }
        if (channelindex == "cartoon") {
            $("#summary .casts").removeWithoutLeaking();
        }
    } catch (e) {
    }

    allsearch(data.title);

    $("#summary .tooltip").tooltip();

    $("body").removeClass("loading");

    try {
        $(".qBox.qdata").append('<a href="https://en.wikipedia.org/wiki/' + encodeURI(data.original_title) + '" rel="nofllow">Wiki</a>');
        $(".qBox.qreview").append('<a href="http://www.imdb.com/find?q=' + encodeURI(data.original_title) + '" rel="nofllow">IMDB</a><a href="https://www.rottentomatoes.com/search/?search=' + encodeURI(data.original_title) + '" rel="nofllow">烂番茄</a>');
        if ($("body.search").length > 0) {
            $(".right h1").first().html(data.title);
            otitle = data.title + " · MVCAT";
            shareData.title = data.title + " / " + data.rating.average + "分";
            if (directors != undefined) {
                directors = $("<p>" + directors + "</p>").text() + '导演，'
            } else {
                directors = ""
            }
            ;
            if (casts != undefined) {
                casts = $("<p>" + casts + "</p>").text() + '主演的'
            } else {
                casts = ""
            }
            ;
            shareData.desc = data.year + '年上映，由' + directors + casts + data.genres + '电影。'
            shareData.imgUrl = data.images.small;
            FshareData();
        }
    } catch (e) {
    }

}//end movieinfo


//getJSONP
var responseHandler; // 定义一个全局作用域的函数

function getJSONP(url, success, error) {
    if (url.indexOf('?') === -1) {
        url += '?callback=responseHandler';
    } else {
        url += '&callback=responseHandler';
    }

    // 创建script 标签
    var script = document.createElement('script');


    // 在函数内部实现包裹函数，因为要用到
    responseHandler = function (json) {
        success(json)
    }

    script.setAttribute('src', url)
    document.body.appendChild(script);
    script.onload = function () {
        script.parentNode.removeChild(script);
    }
    script.onerror = function () {
        error()
    }
}

//end getJSONP

//getJSONP('https://api.douban.com/v2/movie/subject/26891256?apikey=0df993c66c0c636e29ecbb5344252a4a',(e)=> {console.log(e.images.large)});

//douban movie api

function doubanmovie(id) {
    $("body").addClass("loading");
    var durl = "https://movie.douban.com/subject/" + id;
    var apiurl = "https://api.douban.com/v2/movie/subject/" + id + "?apikey=0df993c66c0c636e29ecbb5344252a4a";

    getJSONP(apiurl, function (data) {
        movieinfo(data, durl);
        checkmovieurl();
        console.log(data);
    }, function () {
        allsearch(title);
        $("body").removeClass("loading");
    });


//    $.ajax({
//        type:"GET",
//        timeout:5,
//        url:apiurl,
//        dataType:"jsonp",
//        success:function(data) {
//			console.log(data);
//            movieinfo(data,durl);
//
//        },
//        //end success
//        error:function(data) {
//            allsearch(title);
//            //jsalert("加载失败，请稍候重试！", 5e3);
//        }
//    });

}

//end doubanmovie()

if (/douban.com\/subject\//.test(source)) {
    var id = source.split("/subject/")[1].split("/")[0];
    doubanmovie(id);
} else if ($('body.content.movie').length > 0) {
    allsearch(title);
}


//#mplay 点击
$("body").on("click", "#mplay", function () {
    if (bgm) {
        saveCookie('bgm', 'pause', 60);
    } else {
        saveCookie('bgm', 'play', 60);
    }
});


//#mplay 双击
$("body").on("dblclick", "#mplay", function () {
    var url = $("#mplay").attr("data-url");
    media = $("#mplay").attr("data-media");
    if (url != "undefined") {
        popIframe(url);
        return false;
    } else if (media != "undefined") {
        popIframe(media);
        return false;
    } else {
        return false;
    }
})

//点击播放
$("body").on("click", ".cover", function () {
    if ($(this).hasClass("playing")) {
        bgmPause();
    } else {
        if ($(this).is($("#mplay")) && $("body.root.mvcat.swipeLeft").length > 0) {
            randomsong();
        } else {
            bgmPlay($(this));
        }
    }
});

/*
 * 将秒数格式化时间
 * @param {Number} seconds: 整数类型的秒数
 * @return {String} time: 格式化之后的时间
 */
function formatTime(seconds) {
    var min = Math.floor(seconds / 60),
        second = Math.round(seconds % 60),
        hour, newMin, time;

    if (min > 60) {
        hour = Math.floor(min / 60);
        newMin = min % 60;
    }

    if (second < 10) {
        second = '0' + second;
    }
    if (min < 10) {
        min = '0' + min;
    }

    return time = hour ? (hour + ':' + newMin + ':' + second) : (min + ':' + second);
}

//////

//音乐快捷键


function vol(obj, step) {
    var volume = obj.volume + step;
    if (volume >= 1) {
        volume = 1;
    }
    if (volume <= 0) {
        volume = 0;
    }
    obj.volume = volume;
    jsalert("音量调节：" + Math.round(volume * 100) + "%");
    saveCookie('volume', volume, 60);
}

function volup() {
    if (bgm == false) {
        bgmPlay($("#mplay"));
    }
    ;
    try {
        vol($("#aplayer")[0], 0.05)
    } catch (err) {
        jsalert("当前状态不支持：音量调节")
    }
    ;
}

function voldown() {
    if (bgm == false) {
        bgmPlay($("#mplay"));
    }
    ;
    try {
        vol($("#aplayer")[0], -0.05)
    } catch (err) {
        jsalert("当前状态不支持：音量调节")
    }
    ;
}

function fast(obj, step) {
    var t = obj.currentTime + step;
    var tt = obj.duration;
    if (t >= tt) {
        t = tt;
    }
    if (t <= 0) {
        t = 0;
    }
    obj.currentTime = t;
    if (step > 0) {
        jsalert("快进：" + formatTime(t) + "/" + formatTime(tt))
    } else {
        jsalert("快退：" + formatTime(t) + "/" + formatTime(tt))
    }
}

function FF() {
    if (bgm == false) {
        bgmPlay($("#mplay"));
    }
    ;
    try {
        fast($("#aplayer")[0], 5)
    } catch (err) {
        jsalert("当前状态不支持：快进")

    }
    ;
}

function FR() {
    if (bgm == false) {
        bgmPlay($("#mplay"));
    }
    ;
    try {
        fast($("#aplayer")[0], -5)
    } catch (err) {
        jsalert("当前状态不支持：快退")
    }
    ;
}

//randomsong

var cyclemode = getCookie("cyclemode") || "random";
var clicktrigger = "off";

function randomsong() {
    if ($(".randomsong").length > 0) {
        var p = $(".randomsong").first().parents("span[id*='ajaxElement_']");

        if (counter >= 3 && !fullscreen && !isHtml5Plus) location.reload();//性能
        bgmStop();
        eval("stlDynamic_" + p.attr("id") + "()");
        $("body").addClass("loading");
        jsalert("随机一首");


    } else if ($("body.music .right .list .cover:visible").length >= 2) {
        var i = Math.round(Math.random() * ($(".list .cover:visible").length - 1));
        bgmPlay($(".list .cover:visible").eq(i));
        jsalert("随机一首：" + $(".list .cover.playing").attr("data-title"));
        $("html,body").animate({
            scrollTop: $(".list .cover.playing").offset().top - 30
        }, 500);
    } else {

        bgmPlay($("#mplay"));
        jsalert("循环播放：" + mediaTitle);
    }
    //randmode();
    clicktrigger = "on";
}

//切歌

function prevsong() {
    if (cyclemode == "random" || $(".list .cover:visible").length <= 1) {
        randomsong()
    } else {
        var i = $(".list .cover:visible").index($(".list .cover.playing")) - 1;
        if (i < 0) {
            i = $(".list .cover:visible").length - 1;
        }
        ;
        bgmPlay($(".list .cover:visible").eq(i));
        jsalert("上一首：" + $(".list .cover.playing").attr("data-title"));
        $("html,body").animate({
            scrollTop: $(".list .cover.playing").offset().top - 30
        }, 500);
    }
}

function nextsong() {
    if (cyclemode == "random" || $(".list .cover:visible").length <= 1) {
        randomsong()
    } else {
        var i = $(".list .cover:visible").index($(".list .cover.playing")) + 1;
        if (i > $(".list .cover:visible").length - 1) {
            i = 0;
        }
        ;
        bgmPlay($(".list .cover:visible").eq(i));
        jsalert("下一首：《" + $(".list .cover.playing").attr("data-title") + "》" + $(".list .cover.playing").attr("data-summary"));
        $("html,body").animate({
            scrollTop: $(".list .cover.playing").offset().top - 30
        }, 500);
    }
}

function autonext(e) {
    e.loop = false;

    e.onended = function () {
        if (cyclemode == "random") {
            randomsong();
        } else {
            e.play();
            jsalert("单曲循环：" + mediaTitle);
        }
    }
}

function randmode() {
    $('body').addClass('随机').removeClass('单曲');
    cyclemode = "random";
}

function singlemode() {
    $('body').addClass('单曲').removeClass('随机');
    cyclemode = "single";
}

function togglecyclemode() {
    if (cyclemode == "single") {
        randmode();
        jsalert("随机模式");
        saveCookie("cyclemode", "random", 3600);
    } else {
        singlemode();
        jsalert("单曲循环");
        saveCookie("cyclemode", "single", 3600);
    }
}

function togglemusicmask() {
    if (!musicmask) {
        musicmask = true;
        musicmasker();
        saveCookie("musicmask", "on", 3600);
        jsalert("开启背景图片！", 3000);
    } else {
        $("body").removeClass("bgmask");
        $("body").removeClass("action war sf suspense comedy love spirit cartoon horror crime erotic documentary drama cult joy anger sorrow happy fear love hate lust poem prose motto toplist playlist");
        try {
            $("div.musicmask .layer").ripples('destroy')
        } catch (err) {
        }
        ;
        $("body .musicmask").stop(true, false).fadeOut(1500, function () {
            $("body .musicmask").removeWithoutLeaking();
        });
        musicmask = false;
        saveCookie("musicmask", "off", 3600);
        if ($("#tempcss").length > 0) {
            $("#tempcss").removeWithoutLeaking();
        }
        ;

        try {
            $("#bloodsmoke,#vertexShader,#fragmentShader").removeWithoutLeaking();
        } catch (err) {
        }
        jsalert("关闭背景图片");
    }
    $(window).trigger("resize");
}


$(document).keydown(function (event) {

    if (event.ctrlKey || event.shiftKey || event.altKey || event.metaKey || /input|textarea/.test(document.activeElement.tagName.toLowerCase())) {
        return;
    } else {

        event.preventDefault();
    }

    switch (event.keyCode) {

        // space/enter 播放／停止
        case 32:
        case 13:
            $("#mplay").click();
            break;
        // 多媒体停止 播放／停止
        case 179:
            $("#mplay").click();
            break;
        //上 上一曲
        case 38:
            prevsong();
            break;
        //下 下一曲
        case 40:
            nextsong();
            break;
        //右 快进
        case 39:
            FF();
            break;
        //左 快退
        case 37:
            FR();
            break;
        //+= 音量＋
        case 107:
            volup();
            break;
        //+ 音量＋
        case 187:
            volup();
            break;

        //-_ 音量－
        case 109:
            voldown();
            break;
        //－ 音量－
        case 189:

            voldown();

            break;
        //R 随机播放一首
        case 82:
            randomsong();
            break;
        //S 单曲循环
        case 83:
            $("#cyclemode+label").click();
            break;
        //F 全屏
        case 70:
            if (fullscreen) {
                exitFullScreen()
            } else {
                fullScreen()
            }
            ;
            break;
        //N 夜间模式
        case 78:
            if (nightmode) {
                nightmoder("off");
            } else {
                nightmoder("on");
            }
            ;
            break;

        //B bgmask
        case 66:
            $("#musicbg+label").click();
            break;
    }

});
//end bgm ///////////////////////////////////////////////////////

//favorite
function addFavorite(trigger, ftitle, furl) {
    if (!navigator.cookieEnabled) {
        //判断是否支持Cookie
        return;
    } else {
        //if(getCookie('favorite').replace(/[^\u0000-\u00ff]/g,"aa").length>4050)alert("Cookie存储将满！请删除足迹或整理下收藏吧~");
        var tag = $("#favorite .items")[0];//输出结果DIV id
        var hisCount = 10;//足迹限制
        var favCount = 10;//收藏限制
        var myTitle = ftitle || favtitle || document.title.split(" · ")[0];//取标题
        var myUrl = furl || favurl || location.href.split("#")[0].split("http://www.mvcat.com")[1];//取地址
        var expTime = new Date(new Date().setDate(new Date().getDate() + 5e3));//设定过期时间为5000天
        var edp = "|||; expires=" + expTime.toGMTString() + ";domain=.mvcat.com; path=/";//组合Cookie参数
        var allCookie = document.cookie;//取出全部Cookie
        var added = document.cookie.indexOf("^^^" + escape(myUrl) + "$$$") != -1;
        var faved = added && document.cookie.indexOf(escape("favorite:" + myTitle) + "^^^") != -1;
        //收藏红心
        if (faved) {
            $(".addfavorite,#ftool .ffavorite").addClass("red");
        } else {
            $(".addfavorite,#ftool .ffavorite").removeClass("red");
        }
        //显示收藏
        if (trigger == "show") {
            $("#favorite").addClass("show");
        }
        var preDat = "";
        //★预设置顶内容
        if (allCookie.indexOf("favorite=") != -1 && allCookie.indexOf("$$$|||") != -1) {
            //判断是否为第一次浏览
            var myCookieStart = allCookie.indexOf("favorite=") + "favorite=".length;
            var myCookieEnd = allCookie.indexOf("$$$|||");

            var myCookieall = allCookie.substring(myCookieStart, myCookieEnd);
            var myCookie = unescape(myCookieall).split("$$$");
            var myCookieTit = new Array();
            var myCookieUrl = new Array();
            for (var i = 0; i < myCookie.length; i++) {
                var myCookieOne = myCookie[i].split("^^^");
                myCookieTit[i] = myCookieOne[0];
                myCookieUrl[i] = myCookieOne[1];

            }
            var favDat = "";
            var hisDat = "";
            var mfavDat = "";

            var mhisDat = "";
            for (var i = 0; i < myCookie.length; i++) {
                if (/(已删除)/.test(myCookieTit[i])) continue;
                if (/favorite:/.test(myCookieTit[i])) {
                    if (/\/music/.test(myCookieUrl[i])) {
                        var icon = "music";
                        mfavDat += '<a class="list text" href="' + myCookieUrl[i] + '"><span class="icon red ' + icon + '"></span><span>' + myCookieTit[i].replace("favorite:", "") + "</span></a>";
                    } else {
                        var icon = "heart";
                        favDat += '<a class="list text" href="' + myCookieUrl[i] + '"><span class="icon red ' + icon + '"></span><span>' + myCookieTit[i].replace("favorite:", "") + "</span></a>";

                    }
                } else if (/history:/.test(myCookieTit[i])) {
                    if (/\/music/.test(myCookieUrl[i])) {
                        var icon = "music history";
                        mhisDat += '<a class="list text" href="' + myCookieUrl[i] + '"><span class="icon ' + icon + '"></span><span>' + myCookieTit[i].replace("history:", "") + "</span></a>";
                    } else {
                        var icon = "history";
                        hisDat += '<a class="list text" href="' + myCookieUrl[i] + '"><span class="icon ' + icon + '"></span><span>' + myCookieTit[i].replace("history:", "") + "</span></a>";
                    }
                }
            }
            //end for
            if ($("body.music").length > 0) {
                var Dat = mfavDat + mhisDat;
            } else {
                var Dat = preDat + favDat + hisDat;
            }
            tag.innerHTML = Dat;
            //输出结果给页面div
            try {
                $(".favorite .items").html(Dat);
            } catch (err) {
            }
            //页面收藏
            var favCookie = "";
            var hisCookie = "";
            for (var i = 0; i < myCookie.length; i++) {
                if (myCookieUrl[i] == myUrl || /(已删除)/.test(myCookieTit[i])) continue;
                //排序去重
                if (/favorite:/.test(myCookieTit[i])) {
                    if (favCookie.split("$$$").length >= favCount) {
                        //数量限制
                        //jsalert("已达到最大收藏数量<" + favCount + ">,最早的收藏将被覆盖！");
                        continue;
                    }
                    favCookie += escape(myCookieTit[i]) + "^^^" + escape(myCookieUrl[i]) + "$$$";
                } else if (/history:/.test(myCookieTit[i])) {
                    if (hisCookie.split("$$$").length >= hisCount) {

                        //数量限制
                        //jsalert("已达到最大历史记录<"+ hisCount +">,最早的记录将被覆盖！");
                        continue;
                    }
                    hisCookie += escape(myCookieTit[i]) + "^^^" + escape(myCookieUrl[i]) + "$$$";
                }
            }
            var newCookie = favCookie + hisCookie;
            //清空
            if (trigger == "clear") {
                if (confirm("清空足迹？（收藏将保留）")) {
                    if (faved) {
                        document.cookie = "favorite=" + escape("favorite:" + myTitle) + "^^^" + escape(myUrl) + "$$$" + favCookie + edp;
                    } else {
                        document.cookie = "favorite=" + escape("history:" + myTitle) + "^^^" + escape(myUrl) + "$$$" + favCookie + edp;
                    }
                    addFavorite();
                    jsalert("已清空足迹！");
                    //$('#favorite').removeClass("show");
                    return;
                }
            }
            if (trigger == "add") {
                if (!faved) {
                    //添加收藏
                    document.cookie = "favorite=" + escape("favorite:" + myTitle) + "^^^" + escape(myUrl) + "$$$" + newCookie + edp;
                    addFavorite();

                    if ($("#favorite").hasClass("show")) {

                        jsalert("已收藏《" + myTitle + "》");
                    } else {
                        if (isMobile) {

                            jsalert("已收藏！");
                        }
                        if (!isMobile) {
                            jsalert("已收藏！鼠标移到红心进入收藏夹～", 3e3);
                        }


                    }
                } else {
                    //删除收藏

                    document.cookie = "favorite=" + newCookie.replace(escape(myTitle), escape("favorite:(已删除)" + myTitle)) + edp;
                    addFavorite();
                    jsalert("已取消收藏");
                }
            } else {
                //window.addEventListener('unload',function(){//关闭时保存
                if ($("body.root.mvcat").length > 0) return;

                //忽略首页
                if (faved) {
                    //排序
                    document.cookie = "favorite=" + escape("favorite:" + myTitle) + "^^^" + escape(myUrl) + "$$$" + newCookie + edp;
                } else {
                    document.cookie = "favorite=" + escape("history:" + myTitle) + "^^^" + escape(myUrl) + "$$$" + newCookie + edp;
                }
            }
        } else {
            //第一次浏览
            tag.innerHTML = "";
            try {
                $(".favorite .items").html(preDat);
            } catch (err) {
            }
            //页面收藏
            //if($(".favorite .items").length>0)return;
            if ($("body.root.mvcat").length > 0) return;
            //忽略首页
            document.cookie = "favorite=" + escape("history:" + myTitle) + "^^^" + escape(myUrl) + "$$$" + edp;
        }
    }
}

//end addFavorite

// copyright
if ($(".movies #content,.wiki #content").length > 0) {
    $("#content").after('<p class="copyright clear">© 转载请注明：<a href="' + currenturl + '">《' + title + '》' + currenturl + '</a></p>');
}

//sohucs textarea

var sohucstimer = setInterval(function () {
    if ($("#SOHUCS textarea").length > 0) {
        //$("#SOHUCS textarea").attr("placeholder","推荐你喜欢的"+tags+"电影，影猫会整理收录(=^ ^=)～");
        //$("#SOHUCS textarea").val("我要推荐"+tags+"电影！\r\n电影名称：\r\n推荐理由：")

        // channel song
        if ($("body.song").length > 0) {
            $("#SOHUCS textarea").attr("placeholder", "有好听的同类歌曲，请一定留言分享哦(=^ ^=)～");
            $("#SOHUCS textarea").val("");
        }

        // content movie
        if ($("body.content.movie").length > 0) {
            $("#SOHUCS textarea").attr("placeholder", "如果观看地址失效，或者有更好的资源，请在此留言。影猫会更新收录(=^ ^=)～");
            $("#SOHUCS textarea").val("")
        }

        clearInterval(sohucstimer);
    }
}, 1000)


var playing = false;

//感谢 张鑫旭博客：http://www.zhangxinxu.com/wordpress/2017/06/html5-web-audio-api-js-ux-voice/
window.AudioContext = window.AudioContext || window.webkitAudioContext;

function playTone() {
    if (!window.AudioContext || isMobile) {
        return;
    }
    ;
    var e = "a,input,textarea,img,.cover,label,.closemask,#content .img,body.calendar span,.daodream-launcher-button"; //音效元素
    var audioCtx = new AudioContext();
    var arrFrequency = [196.00, 220.00, 246.94, 261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25, 587.33, 659.25, 698.46, 783.99, 880.00, 987.77, 1046.50];
    var start = 0,
        direction = 1;
    $(document).on('mouseenter', e, function () {
        if (bgm || playing || !playtone) {
            return;
        }
        ;
        var frequency = arrFrequency[start];
        if (!frequency) {
            direction = -1 * direction;
            start = start + 2 * direction;
            frequency = arrFrequency[start]
        }

        start = start + direction;
        var oscillator = audioCtx.createOscillator();
        var gainNode = audioCtx.createGain();
        oscillator.connect(gainNode);
        gainNode.connect(audioCtx.destination);
        oscillator.type = 'sine';
        oscillator.frequency.value = frequency;
        gainNode.gain.setValueAtTime(0, audioCtx.currentTime);
        gainNode.gain.linearRampToValueAtTime(1, audioCtx.currentTime + 0.01);
        oscillator.start(audioCtx.currentTime);
        gainNode.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + 1);
        oscillator.stop(audioCtx.currentTime + 1)
    })
};
////////////////////DOC READY
$(document).ready(function () {
    //setTimeout(function(){
    //$("body").removeClass("loading");
    //},2000);
    $(function () {
        var hash = location.hash.replace("#", "");
        if (/http:|https:/.test(hash)) {
            if (isIos && isSafari) {
                window.open(hash);


            } else {
                popIframe(hash);
            }
        } else if (/mvcat:/.test(hash)) {
            popIframe("http://www.mvcat.com/api/url/?" + hash);
        } else if ($("*[href='#" + hash + "],*[id='" + hash + "']").length > 0) {
            $("*[href='#" + hash + "],*[id='" + hash + "']").click();
        }

    })

    //music autostart
    if ($("body.channel.music").not(".root").find(".right .list .cover").length > 0 || $("body.content.music").length > 0) {
        var i = Math.round(Math.random() * ($(".right .cover:visible").length - 1));
        bgmPlay($(".right .cover:visible").eq(i));
    }

    //ifvisible.js
    //if($("body.root.music").length>0)
    ifvisible.setIdleDuration(15);//seconds

    ifvisible.on("idle", function () {
        if ($("body.popmaskon").length == 0) $("body").removeClass("wakeup").addClass("idle");
    });

    ifvisible.on("wakeup", function () {
        $("body").removeClass("idle").addClass("wakeup");
    });

    // Possible statuses are:
    // idle: when user has no interaction
    // hidden: page is not visible
    // active: page is visible and user is active

    if (ifvisible.now('hidden')) {

    }

    //定时器
    setInterval(function () {

        //themecolor
        themecolor = rgb2hex($(".left .logo .theme").first().css("color") || "#daa520");

        //bgm autostop
        if (getCookie('playtime') > playtime) {
            if (bgm) bgmPause();
        }

        // background playing
        if (isHidden() || $("body.popmaskon").length > 0) {
            if (bgm) {
                saveCookie("playing", 1);
            } else {
                saveCookie("playing", 0);
            }
        }

        //bgm autostop
        if (getCookie('playing') == 1) {
            playing = true;
        } else {
            playing = false;
        }

        // nightmode class
        if ($("body.nightmode").length > 0) {

            $("body").addClass("bgmask");
        }

        //网页标题
        if (bgm && $("body.music.channel").length > 0) {
            var bgmTitle = mediaTitle;

            if (bgmTitle == title || bgmTitle == "背景音乐") bgmTitle = "";
            document.title = bgmTitle + " · " + otitle;
        } else {
            if (isHidden()) {
                document.title = " ..zzZ "
            } else {
                document.title = otitle;
            }
        }

    }, 300);

    // 定时器

    if (!isMobile && $(document.body).height() > $(window).height() * 4) {
        //totop
        $("#ftool").append('<a href="javascript:scrollTo(0,0);" class="icon totop"></a><a href="javascript:scrollTo(0,document.body.scrollHeight);" class="icon tobot"></a>');
        //comment
        if ($("#SOHUCS").length > 0) {
            $("#ftool").append('<a href="#SOHUCS" class="icon fcomment" onClick="$(\'#SOHUCS\').show();$(\'#SOHUCS textarea\')[0].focus();">✎</a>')
        }
    }

    // favorite
    if ($(".left").length > 0) {//判断是否单页
        //$("body").append('<div id="favorite" style="display:none;"><h2>收藏<span style="font-size:0.75em"> & 足迹&nbsp;<span onclick="addFavorite(\'clear\');" style="cursor:pointer;color:red;font-size:0.75em">[清空]</span></span><span onclick="$(\'#favorite\').removeClass(\'show\)" class="close"></span><span class="addfavorite heart" onclick="addFavorite(\'add\');"></span></h2><div class="items clear"></div></div>');
        $("body").append('<div id="favorite"><h2>收藏<span onclick="$(\'#favorite\').removeClass(\'show\')" class="close"></span><span class="addfavorite heart" onclick="addFavorite(\'add\');"></span></h2><div class="items clear"></div></div>');
        $("#ftool").prepend('<a class="icon ffavorite heart" onclick="addFavorite(\'add\');" onmouseover="if($(this).hasClass(\'red\')||$(\'body.root.mvcat\').length>0)addFavorite(\'show\');"></a>');
        //收藏按钮
        $("#favorite,.favorite").on("click", ".icon:not(.star)", function (e) {
            e.preventDefault();
            addFavorite("add", $(this).next("span").text(), $(this).parent("a").attr("href"));
        })
        //刷新收藏
        addFavorite();
        setInterval(function () {

            if (isHidden()) return;
            addFavorite();
        }, 3000);

    }

    //警告
    if ($("body.content[class*='负能量'],body.content[class*='负能量'] h1").length > 1) {
        $(".right h1").first().after('<span class="tag warning">身体不适预警！！！</span>')
    }
    //版权
    if ($("body.content.nocopy h1").length > 0) {
        $(".right h1").first().append('&nbsp;<span class="sorter">版权作品，仅做展示。</span>')

    }

    //站内链接
    $("body").on("click", "a.pop,a[target='popIframe'],.left .submenu a[href*='http'],.qBox a,a.list[href*='http'],.list a[href*='http'],a.list.text,.sorter a[href*='http'],#summary a[href*='http'],.tags a[href*='http'],#content a[href*='http'],body.channel.timeline .right a[href*='http'],#calendar a[href*='http']", function (e) {

        var src = $(this).attr("href");

        if (/javascript/.test(src) || isHtml5Plus) return;

        if (/douban.com|163.com|1905.com/.test(src)) {
            $(this).attr("target", "_blank");
            return;
        }

        e.preventDefault();

        if (isImgUrl(src)) {
            popImg(src);
        } else if ($(this).attr("target") == "_blank" || isHtml5Plus) {
            popIframe(src, "_blank");
        } else {
            if ($(this).hasClass("list")) src = mvcaturl(src);
            popIframe(src);
        }

    }) //站内链接

    //sort
    $(".sortbox").on("click", ".sorter a[href*='#']", function () {
        $(this).siblings("a").removeClass("current");
        $(this).addClass("current");
        var s = $(this).attr("href").split("#")[1] || $(this).text();
        var p = $(this).parents(".sortbox");


        if (p.length > 1) {
            p = p.first().find(".sort");
        } else {
            p = p.first().find(".sort").not(".sortbox .sortbox .sort");
        }

        if (p.filter("." + s).length == 0) {
            insearch(s);
            return false;
        }

        p.hide(0);
        p.filter("." + s).show(0);

        //if (!isMobile) $("html,body").animate({scrollTop: p.filter("." + s).first().offset().top - 10}, 500);


    });

    //selector
    $(".selections").on("click", ".selector", function () {
        var p = $(this).parents(".selections");
        p.find(".selector").removeClass("current");
        $(this).addClass('current');
        p.find(".selection").hide(0);
        p.find('.selection[class*=' + $(this).text() + ']').show(0);
        //if(!isMobile)$("html,body").animate({scrollTop:p.offset().top}, 500);
    });


    //
    $(".left .logo").attr("href", "javascript:location.href='http://www.mvcat.com/player/?url='+location.href").click(function (e) {
        e.preventDefault();
        location.href = "http://www.mvcat.com/"
    });

    //图片弹出层
    $(document).on("mouseover", "#summary,#content", function () {
        popImg($(this));
    });


    if (!isMobile) {
        qSearch('#content'); //快捷搜索
        $(".tooltip").tooltip(); //tooltip
    }

//swipe
    /*$("body").swipe({
        fingers:1,
        threshold:100, // default 75
        cancelThreshold:null,
        pinchThreshold:20,
        maxTimeThreshold:null,
        fingerReleaseThreshold:250,
        longTapThreshold:500,
        doubleTapThreshold:200,
        swipe:null,
        swipeLeft:function() {
            $("body").addClass("swipeLeft").removeClass("swipeRight");
            $(window).trigger("resize");
        },
        swipeRight:function() {
            $("body").addClass("swipeRight").removeClass("swipeLeft");
            $(window).trigger("resize");
        },
        swipeUp:function() {
            $("body").addClass("swipeUp").removeClass("swipeDown");
        },
        swipeDown:function() {
            $("body").addClass("swipeDown").removeClass("swipeUp");
        },
        swipeStatus:null,
        pinchIn:null,
        pinchOut:null,
        pinchStatus:null,
        click:null,//Deprecated since 1.6.2
        tap:null,
        doubleTap:null,
        longTap:null,
        hold:null,
        triggerOnTouchEnd:true,
        triggerOnTouchLeave:false,
        allowPageScroll:"auto",
        fallbackToMouseEvents:true,
        excludedElements:$.fn.swipe.defaults.excludedElements + ",input,textarea,body.inframe,#popImgMask,#echarts,.echarts",
        preventDefaultEvents:true,
        allowPageScroll:"vertical",
        preventDefaultEvents:false
    });*/

//musicroot swipe
    if ($("body.music.root").length > 0) {
        if (isMobile) {
            $("body").swipe({
                swipeLeft: function () {
                    FR();
                },
                swipeRight: function () {
                    FF();
                },
                swipeUp: function () {
                    randomsong();
                },
                swipeDown: function () {
                    $(".ffavorite").click();
                },
                tap: function () {
                    bgmPause();
                },
                excludedElements: $.fn.swipe.defaults.excludedElements + "a,input,textarea,.left,.right,.rightside,#mplay,#ftool,.showleft,#favorite",
                allowPageScroll: "vertical",
                preventDefaultEvents: true
            });
            jsalert("上划切歌", "5000");
        } else {
            $("body").dblclick(function () {
                bgmPause();
            });
            jsalert("右键切歌 双击暂停", "5000");
        }
    }

    if ($(window).scrollTop() == 0) {
        //console.log('顶');
        $("body").addClass("scrollTop");
    }

//scroll
    $(window).scroll(function () {
        var before = $(window).scrollTop();
        $(window).scroll(function () {
            var after = $(window).scrollTop();
            if (after == 0) {
                //console.log('顶');
                $("body").addClass("scrollTop");
            } else if (before < after) {
                //console.log('上');
                $("body").addClass("scrollUp");
                $("body").removeClass("scrollDown scrollTop");
                before = after;
            } else if (before > after) {
                //console.log('下');
                $("body").addClass("scrollDown");
                $("body").removeClass("scrollUp scrollTop");
                before = after;
            }
        });
        //scroll function
        $("#huaci,#tooltip").slideUp(50);
        if ($("#favorite").css("position") == "fixed") $("#favorite").removeClass("show");
    });


    //if($(window).width()<480)try{$(".insearch #word").val("关键词")}catch(e){};
    //
    $(":text,textarea").each(function () {
        var input = $(this);
        var val = "";

        $(this).on("focus", function () {
            val = input.val();
            $(this).val("");
        });
        $(this).on("blur", function () {
            if ($(this).val() === val || $(this).val() === "") {
                $(this).val(val);
            }
        });

        $(':button[id*=submit]').on("mouseover", function () {
            if (input.val() === val) {
                input.val("");
            }

        });


    });

    //fontsize

    function fontSize(attr, n) {
        var e = $(attr);
        var s = e.css("font-size");
        var size = parseFloat(s, 10);
        var unit = s.slice(-2);
        //获取单位
        size += n;
        e.css("font-size", size + unit);
        saveCookie('fontsize' + attr, size + unit, 60);

    }

    //载入cookie
    $('#content').css('font-size', getCookie('fontsize#content'));


    function alertObject(tips, obj) {
        var description = "";
        for (var i in obj) {
            var property = obj[i];

            description += i + " = " + property + "\n";
        }
        alert(tips + "\r\n" + description);
    }

    //微信分享
    if (isWeixin) $.ajax({
        type: "get",
        url: "http://www.mvcat.com/api/wx/jssdk.php?url=" + encodeURIComponent(ourl),
        //替换网址，xxx根据自己jssdk文件位置修改 
        dataType: "jsonp",
        jsonp: "callback",
        jsonpCallback: "success_jsonpCallback",

        success: function (data) {
            console.log(data);
            //alert("连接成功！"+data); 
            wx.config({
                appId: data.appId,
                timestamp: data.timestamp,
                nonceStr: data.nonceStr,
                signature: data.signature,
                jsApiList: ["updateAppMessageShareData", //自定义“分享给朋友”及“分享到QQ”按钮的分享内容（1.4.0）
                    "updateTimelineShareData" //自定义“分享到朋友圈”及“分享到QQ空间”按钮的分享内容（1.4.0）
                ]
            });
        },
        error: function (data) {
            console.log(data);
            //alertObject("ajax出错",data); 
        }
    });

    wx.ready(function () {
        //alertObject("wx.ready！",shareData);
        wx.updateAppMessageShareData(shareData);
        wx.updateTimelineShareData(shareData);
    });

    wx.error(function (res) {
        console.log(res);
        //alertObject("wx.error",res); 
        //config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。

    });
});
//end of docready

//window onload
//window.onload=function(){
//if(!isMobile || inFrame || !isIE678){nanobar.go(100);}
//}
// end window onload

//禁止长按菜单
if ($('body.channel').length > 0 && isMobile) {
    $('body').bind('contextmenu', function (e) {
        e.preventDefault();
        return false;
    })
}