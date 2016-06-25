/**
 * 完善资料页面功能
 * zengjie
 * 14/3/15
 */
function setPageHeight(){
	$("#regist-wrap-inner").css("min-height",document.body.scrollHeight-86);
}
/*创建命名空间*/
var registModel = angular.module('registApp',[]);

/*main函数*/
registModel.run(function($rootScope){
	//$rootScope.address=GenerAddressInfoSV.init();
});

/*创建模糊查询过滤器*/

/*创建服务工厂来获取数据*/
registModel.factory('GetInfoServer',function($http){
		return {
			get : function(){
				return $http.get(root+"/info/getInput").then(function(data,status,headers,config){
	                return data.data; //成功回调则返回这个
	            });
			}
		};
});
/*设置realValue*/
registModel.directive('setRealValue',function(){
	return {
		 require: 'ngModel',
		 link: function(scope, ele, attrs, c) {
			 ele.on('change',function(){
				 var text = ele[0].options[ele[0].selectedIndex].text;
				 scope.$parent.item.realValue=text;
			 });
		    	/*scope.$watch(attrs.ngModel, function() {
		    		
		    	});*/
		 }
	};
});
/*angularjs ng-option ie issue解决方案*/
registModel.directive('ieSelectFix', [
    function () {
        return {
            restrict: 'A',
            require: 'select',
            link: function (scope, element, attributes) {
                var isIE = document.attachEvent;
                if (!isIE) return;
                var control = element[0];
 
                scope.$watch(attributes.ieSelectFix, function () {
 
                    //it should be use javascript way, not jquery way.
 
                    var option = document.createElement("option");
 
                    control.add(option, null);
 
                    control.remove(control.options.length - 1);
 
                });
 
            }
 
        }
 
    }
 
]);
/*改变居住地的省份*/
registModel.directive("changeProvince",function(){
	return {
		link : function(scope,ele,attrs,c){
			ele.on('change',function(){
				//设置realValue
				 var text = ele[0].options[ele[0].selectedIndex].text;
				 scope.$parent.item.realValue=text;
			});
		}
	};
});
registModel.directive("changeCity",function(){
	return {
		link : function(scope,ele,attrs,c){
			ele.on('change',function(){
				//设置realValue
				 var text = ele[0].options[ele[0].selectedIndex].text;
				 scope.$parent.item.realValue=scope.$parent.item.realValue+"-"+text;
			});
		}
	};
});
registModel.directive('toSearch', ['$http', function($http) {
	  return {
	    require: 'ngModel',
	    link: function(scope, ele, attrs, c) {
	      scope.$watch(attrs.ngModel, function() {
	    	  var selected = scope.$parent.selected;
	    	  if(c.$dirty && !selected){
	    		  $http({
	    	          method: 'POST',
	    	          url: root+"/info/getBySearchCondition",
	    	          data: {"infoId":attrs.name,"searchName":c.$modelValue}
	    	        }).success(function(data, status, headers, cfg) {
	    	        	scope.queryitems=data.data;
	    	        	if(data.data && data.data.length>0){
	    	        		scope.$parent.$parent.showQuery = true;
	    	        	}else{
	    	        		scope.$parent.$parent.showQuery = false;
	    	        	}
	    	        }).error(function(data, status, headers, cfg) {
	    	        	scope.queryitems=[];
	    	        });
	    	  }else{
	    		  scope.$parent.selected=false;
	    	  }
	      });
	    }
	  };
	}]);
/*创建controller*/
registModel.controller('RegistController',function($scope,$http,$window,GetInfoServer){
	$window.setPageHeight();
	$scope.showQuery=false;
	$scope.alertShow=false;
	$scope.selected=false;
	$scope.address={};
	$scope.province="";
	$scope.city="";
	$scope.addressStr=$scope.city;
	$scope.setQueryValue =  function(target,infoid){
		$scope.showQuery=false;
		var value = angular.element(target).text();
		angular.element("#"+infoid).scope().$parent.item.value=jQuery.trim(value);
		angular.element("#"+infoid).scope().$parent.selected=true;
	};
	/*初始化居住地址值*/
	$scope.initAddress = function(k,v){
		var a = $scope.items[k].extendInfo;
		for (var i in a){
			if(a[i].regionId==v){
				$scope.province = a[i].regionId;
				$scope.address.city=a[i].children;
				break;
			}
		}
		var city = $scope.address.city;
		for (var i in city){
			if(city[i].regionId==$scope.city){
				$scope.city = city[i].regionId;
				break;
			}
		}
	};
	$scope.changeProvince = function(infoid,v,target){
		$scope.city="";
		angular.element("#"+infoid).scope().$parent.item.value=v;
		$scope.province =v;
		var a=angular.element("#"+infoid).scope().$parent.item.extendInfo;
		for (var i in a){
			if(a[i].regionId==v){
				$scope.address.city=a[i].children;
				break;
			}
		}
	
	};
	$scope.changeCity= function(infoid,v,flag){
		$scope.city=v;
	    angular.element("#"+infoid).scope().$parent.item.value=	$scope.province+","+$scope.city;
	};
	$http.get(root+"/info/getInput").success(function(data,status,headers,config){
		//获取数据成功
		if(data.data){
			$scope.items=data.data; 
			for(var i in $scope.items){
				if($scope.items[i].infoId=="RESIDENT_ADDRESS"){
					var value = $scope.items[i].value;
					if(value){
						var valueArr = value.split(",");
						$scope.province=valueArr[0];
						$scope.city=valueArr[1];
					}
				}
			}
			$scope.loading=false;
			angular.element("#loading").addClass("hidden");
			angular.element("#regist-wrap-inner").removeClass("hidden");
			
		}else{
			$scope.alertInfo="从服务端获取个人信息失败！";
		}
	}).error(function(data,status,headers,config){
		//处理错误
		$scope.alertInfo="连接服务端失败！";
	});
	$scope.submitInfo = function(items){
		if($scope.registForm.$valid){
			var formData =$scope.items; 
			var form =[];
			for (var i in formData){
				var info ={};
				info.id={"infoId":formData[i].infoId};
				info.value=formData[i].value;
				if(formData[i].valueType!="select" && formData[i].valueType!="address"){
					info.realValue=formData[i].value;
				}else{
					info.realValue= formData[i].realValue;
				}
				
				form.push(info);
			}
			var jsonStr =JSON.stringify(form);
			$http.post(root+"/info/commit",jsonStr,{}).success(function(data, status, headers, config){
				if(data.code=="0"){
					$scope.alertShow=true;
					$scope.alertInfo="保存资料成功!";
					$window.location.href=root+"/exam/sample";
				}else{
					$scope.alertShow=true;
					$scope.alertInfo="保存资料失败,调用服务失败!";
				}
			}).error(function(data, status, headers, config){
				
			});
		}else{
			//$window.alert("请正确完整填写个人资料");
			 $scope.registForm.submitted = true;
		}
		
		
	};
/*  $(document).on("keydown",function (e) { //这里给function一个事件参数命名为e，叫event也行，随意的，e就是IE窗口发生的事件。
	    var key = e.which; //e.which是按键的值
	    if (key == 13) {
	    	if($scope.showQuery){
	    		//选定院校
	    		$scope.showQuery=false;
	    		//var value =  angular.element("#"+e.target.id+" + ul").innerText;
	    		//angular.element(e.target).scope().$parent.item.value=value;
	    	}else{
	    		//提交
	    		//$scope.submitInfo();
	    	}
	    	
	    }
	});*/
	
	$scope.clearInput=function(target,value){
		if((target.placeholder == target.value)|| (!target.value)){
			target.value="";
		}
	};
	$scope.queryIndex = 0; //当前的索引
	$scope.queryFocus = function(e){
		var li = angular.element("#"+e.target.id+" + ul")[0].getElementsByTagName('li');
		var length = angular.element("#"+e.target.id+" + ul").children("li").length;
		if($scope.showQuery){
			 if(40 == e.keyCode) { //按键盘向下键
			        if(++$scope.queryIndex == length+1) { $scope.queryIndex = 1; }
			        $scope.setView(li, $scope.queryIndex);
		    }
		    if(38 == e.keyCode) {//按键盘向上键
		        if(--$scope.queryIndex == 0) { $scope.queryIndex = length; }
		        $scope. setView(li, $scope.queryIndex);
		    }
		    if(13 == e.keyCode){//回车键
		    	$scope.showQuery=false;
		    	$scope.queryIndex = 0;
		    }
		}
		 
	};
	$scope.setView = function(elems, index) {
	    for(var j = 0; j < elems.length; j++) {
	    	angular.element(elems[j]).removeClass("query-menu-hover");
	    }
	    var value = angular.element(elems[index-1]).text();
		angular.element(elems).scope().$parent.$parent.item.value=jQuery.trim(value);
		angular.element(elems).scope().$parent.$parent.selected=true;
	    angular.element(elems[index-1]).addClass("query-menu-hover");
	};
	$scope.isqueryHover = false;
	$scope.queryHover = function(target){
		 angular.element(target).removeClass("query-menu-hover");
		 $scope.isqueryHover=true;
	};
	$scope.onBlurQuery = function(target){
		if(!$scope.isqueryHover){
			$scope.showQuery=false;
		}
	};
	$scope.onFocusQuery = function(target){
		var a =angular.element("#"+target.id+"+ ul").children("li");
		if(a.length>0){
			$scope.showQuery=true;
		}
	};
});
