// 获得地址栏中category的值
var url = decodeURI(window.location.search);
var type = url.substring(url.lastIndexOf('=') + 1);
var country;
var year;
var score;

$(document).ready(function () {
    // 将对应种类的标签背景置红
    $("#menu a").each(function () {
        if ($(this).text() === type) {
            $(this).addClass("bg-danger");
        } else {
            $(this).removeClass("bg-danger");
        }
    });
    var indexs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    indexs = getRandom(indexs);
    console.log(indexs);
    $("#trans3DBoxes1").children().each(function (index) {
        var imgUrl = $(".card").find("img").eq(indexs[index + 6]).attr("src");
        if (imgUrl !== "") {
            console.log(imgUrl);
            $(this).css("background-image", "url(" + imgUrl + ")");
        }

    });
});

function getRandom(result) {
    var n = result.length;
    for (var i = 0; i < n; i++) {
        result[i] = i;
    }

    var half = n / 2;
    for (var j = 0; j < half; j++) {
        var pos = Math.ceil(Math.random() * (n - j)) + j;
        var tmp = result[j];
        result[j] = result[pos];
        result[pos] = tmp;
    }
    return result;
}

// 种类被点击时，更换按钮样式
$("#menu>a").click(function () {
    $("#menu a").removeClass("bg-danger");
    $(this).addClass("bg-danger");
});

//选择年份触发的点击事件
$("#year a").click(function () {
    year = $(this).text();
    $("#year a").first().text(year);
    $("#year a").first().toggleClass("bg-danger");
    if ($(this).hasClass("dropdown-item")) {

        //判断一下当前是第几页，如果不是第一页，从第一页开始
        $("#fenye li").children().filter(".myactive").removeClass("myactive");
        $("#fenye li").eq(1).children().addClass("myactive");

        conditionAjax(type, year, country, score, 1);

    }

});

//选择国家触发的点击事件
$("#country a").click(function () {
    country = $(this).text();
    $("#country a").first().text($(this).text());
    $("#country a").first().toggleClass("bg-danger");
    console.log($(this).text());
    if ($(this).hasClass("dropdown-item")) {


        //判断一下当前是第几页，如果不是第一页，从第一页开始
        $("#fenye li").children().filter(".myactive").removeClass("myactive");
        $("#fenye li").eq(1).children().addClass("myactive");
        conditionAjax(type, year, country, score, 1);
    }
});


var $fenye = $("#fenye").children();

$fenye.click(function () {
    var number=0;
    var hideCount = 0;
    $fenye.each(function () {
        // 如果 li标签没有这个 class属性，则代表是可见的，则长度加1
        if(!$(this).hasClass("d-none")){
            number += 1;
        }else{
            hideCount += 1;
        }
    });
    // console.log($(this).index());
    var index = $(this).index();
    if(index > number){
        index = $(this).index() - hideCount;
    }
    var $now = $fenye.children().filter(".myactive");
    // console.log(index)
    // 左边界
    var left = $now.parent().prev().index();
    // 右边界
    var right = $now.parent().next().index();
    // console.log("left: " + left + " right:" + right)

    // 左右箭头
    if (index === 0 && left !== 0) {
        $now.removeClass("myactive");
        $now.parent().prev().children().addClass("myactive");
        nextData($now.parent().prev().index())
    } else if (index === number - 1 && right !== number - 1) {
        $now.removeClass("myactive");
        $now.parent().next().children().addClass("myactive");
        nextData($now.parent().next().index())
    }
    if (index > 0 && index < number - 1) {
        $(this).siblings().children().removeClass("myactive");
        $(this).find("a").addClass("myactive");
        nextData(index)
    }
    // 控制左右箭头是否可点击
    $now = $fenye.children().filter(".myactive");
    // 左边界
    left = $now.parent().prev().index();
    // 右边界
    right = $now.parent().next().index();
    console.log("index:" + index + " number: " + number + " right:" + right);
    if (index === 1 || left === 0) {
        $("#leftArr").addClass("disabled");
    } else {
        $("#leftArr").removeClass("disabled");
    }
    if (index === number - 2 || right === number - 1 || index === number - 1) {
        $("#rightArr").addClass("disabled");
    } else {
        $("#rightArr").removeClass("disabled");
    }
});

// 选择下一页时触发的ajax事件
function conditionAjax(type, year, country, score, index) {
    var dataUrl;
    // 如果年份、分数、国家都没选择
    if (typeof (year) == "undefined" && typeof (country) == "undefined" && typeof (score) == "undefined") {
        dataUrl = "page=" + index + "&type=" + type + "&choose=none";
    } else if (typeof (year) !== "undefined" && typeof (country) == "undefined" && typeof (score) == "undefined") {
        // 如果只选择了年份
        dataUrl = "page=" + index + "&type=" + type + "&year=" + year + "&choose=Y";
    } else if (typeof (year) == "undefined" && typeof (country) !== "undefined" && typeof (score) == "undefined") {
        // 如果只选择了国家
        dataUrl = "page=" + index + "&type=" + type + "&country=" + country + "&choose=G";
    } else if (typeof (year) == "undefined" && typeof (country) == "undefined" && typeof (score) !== "undefined") {
        // 如果只选择了分数
        dataUrl = "page=" + index + "&type=" + type + "&score=" + score + "&choose=S";
    } else if (typeof (year) !== "undefined" && typeof (country) !== "undefined" && typeof (score) == "undefined") {
        // 如果选择了年份和国家
        dataUrl = "page=" + index + "&type=" + type + "&year=" + year + "&country=" + country + "&choose=YG";
    } else if (typeof (year) !== "undefined" && typeof (country) == "undefined" && typeof (score) !== "undefined") {
        // 如果选择了年份和分数
        dataUrl = "page=" + index + "&type=" + type + "&year=" + year + "&score=" + score + "&choose=YS";
    } else if (typeof (year) == "undefined" && typeof (country) !== "undefined" && typeof (score) !== "undefined") {
        // 如果选择了国家和分数
        dataUrl = "page=" + index + "&type=" + type + "&score=" + score + "&country=" + country + "&choose=GS";
    } else {
        // 如果三者都选择了
        dataUrl = "page=" + index + "&type=" + type + "&year=" + year + "&country=" + country + "&score=" + score + "&choose=YGS";
    }
    // console.log(dataUrl);

    $.ajax({
        url: "updateData",
        data: dataUrl,
        success: function (data) {
            var arr = data.split('|');
            // 符合条件的电影数量
            var length = arr[1];
            var pageCount = Math.ceil(length / 12);
            console.log("pageCount: " + pageCount);
            // 获取总的页数，改变页面导航栏
            $("#fenye li").each(function (index) {
                console.log("显示/隐藏：" + index);
                // 如果当前的li标签索引大于要显示的页数，则隐藏，否则显示
                if (index > pageCount && index !== $("#fenye li").length - 1) {
                    $(this).addClass("d-none");
                }else{
                    $(this).removeClass("d-none");
                }
            });

            var json = eval(arr[0]);
            // console.log(json);
            update(json);
        }
    });
}


function nextData(index) {
    var url = decodeURI(window.location.search);
    var type = url.substring(url.lastIndexOf('=') + 1);
    conditionAjax(type, year, country, score, index);
}

function update(json) {
    $(".card").each(function (index) {
        if (index < json.length) {
            var img = $(this).find("a").find("img");
            var movieName = $(this).find("div").find("h5");
            var year = $(this).find("div").find("p").find("small").first();
            var url = $(this).find("a");
            var score = $(this).find("div").find("small").children().filter("#m-score");

            $(img).attr("src", json[index].image);
            $(movieName).text(json[index].name);
            $(year).text(json[index].years);
            $(url).attr("href", "detail?movieName=" + json[index].name);
            $(score).text(json[index].score);
            $(this).removeClass("d-none")


            if (index < 6) {
                var temp = $("#trans3DBoxes1").children().eq(index);
                console.log(temp);
                $(temp).css("background-image", "url(" + json[index].image + ")");
            }
        } else {
            $(this).addClass("d-none")
        }
    });
    isHaveCollection();
}


$(function () {
    var tag = false,
        ox = 0,
        left = 0,
        bgleft = 0;
    $('.myprogress_btn').mousedown(function (e) {
        ox = e.pageX - left;
        tag = true;
    });

    $('.myprogress_btn').mouseup(function () {
        tag = false;
        if (left !== 0) {
            console.log("移动：" + $('.text').text());
            //判断一下当前是第几页，如果不是第一页，从第一页开始
            $("#fenye li").children().filter(".myactive").removeClass("myactive");
            $("#fenye li").eq(1).children().addClass("myactive");
            conditionAjax(type, year, country, score, 1);
        }
    });

    $('.myprogress').mousemove(function (e) { //鼠标移动
        if (tag) {
            left = e.pageX - ox;
            if (left <= 0) {
                left = 0;
            } else if (left > 300) {
                left = 300;
            }
            $('.myprogress_btn').css('left', left);
            $('.myprogress_bar').width(left);
            score = parseFloat((left / 300) * 10).toFixed(1);
            $('.text').html(score);

        }

    });

    $('.myprogress_bg').click(function (e) { //鼠标点击
        if (!tag) {
            bgleft = $('.myprogress_bg').offset().left;
            left = e.pageX - bgleft;
            if (left <= 0) {
                left = 0;
            } else if (left > 300) {
                left = 300;
            }
            $('.myprogress_btn').css('left', left);
            $('.myprogress_bar').animate({
                width: left
            }, 300);
            // 保留一位小数
            var num = parseFloat((left / 300) * 10);
            score = num.toFixed(1);
            $('.text').html(score);
            console.log("鼠标点击：" + score);
            //判断一下当前是第几页，如果不是第一页，从第一页开始
            $("#fenye li").children().filter(".myactive").removeClass("myactive");
            $("#fenye li").eq(1).children().addClass("myactive");
            conditionAjax(type, year, country, score, 1);

        }
    });
});


function collection(obj) {
    var movieName = $(obj).parent().parent().prev().text().trim();
    var userName = $("#navbardrop").text().trim();
    console.log(movieName + " " + userName);
    if (userName !== "我的账户") {
        $(obj).toggleClass("text-danger");
        $.ajax({
            url: "collection.do",
            data: "movieName=" + movieName + "&userName=" + userName,
        });
    }
}

$(document).ready(function () {
    isHaveCollection();
    isHaveBrowsed();
});

// 判断页面显示的电影中是否有被收藏的电影，如果有，则将爱心置为红色
function isHaveCollection() {
    var userName = $("#navbardrop").text().trim();
    if (userName !== "我的账户") {
        $.ajax({
            url: "collection.do",
            data: "userName=" + userName,
            success: function (data) {
                var json = eval(data);
                // console.log("json" + json + "data" + data);
                $(".card-title").each(function () {
                    var title = $(this).text();
                    // 判断当前页面是否有电影存在记录中
                    var flag = data.lastIndexOf(title);
                    if(flag !== -1){
                        $(this).next().children().eq(1).children().eq(0).addClass("text-danger");
                    }else{
                        $(this).next().children().eq(1).children().eq(0).removeClass("text-danger");
                    }

                });
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}

// 判断页面显示的电影中是否有被浏览过的电影，如果有，则将眼镜置为红色
function isHaveBrowsed() {
    var userName = $("#navbardrop").text().trim();
    console.log("isHaveBrowsed : " + userName);
    if (userName !== "我的账户") {
        $.ajax({
            url: "history.do",
            data: "",
            success: function (data) {
                var json = eval(data);
                $(".card-title").each(function () {
                    var title = $(this).text();
                    // 判断当前页面是否有电影存在记录中
                    var flag = data.lastIndexOf(title);
                    if(flag !== -1){
                        $(this).next().children().eq(1).children().eq(1).addClass("text-danger");
                    }else{
                        $(this).next().children().eq(1).children().eq(1).removeClass("text-danger");
                    }

                });
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}