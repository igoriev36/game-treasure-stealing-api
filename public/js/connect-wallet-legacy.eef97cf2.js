"use strict";(self["webpackChunkgame_treasure_stealing_vue"]=self["webpackChunkgame_treasure_stealing_vue"]||[]).push([[864],{16045:function(t,e,n){n.r(e),n.d(e,{default:function(){return d}});var a=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"connect-wallet-layout"},[n("div",{staticClass:"container"},[n("h1",{staticClass:"align-center"},[t._v("This is an connect wallet page")]),n("div",{staticClass:"align-center"},[n("el-button",{attrs:{loading:t.loading},on:{click:t.fakeConnect}},[t._v("Connect")])],1)])])},i=[],l=n(93019),o=n(34665),c={data:function(){return{loading:!1,redirect:void 0}},watch:{$route:{handler:function(t){console.log(t),this.redirect=t.query&&t.query.redirect},immediate:!0}},methods:(0,l.Z)((0,l.Z)({},(0,o.nv)({login:"users/login"})),{},{fakeConnect:function(){var t=this;this.loading=!0,this.login({email:"tai.ictu@gmail.com",password:"stdev@123456"}).then((function(e){console.log(e),t.$router.push({path:t.redirect||"/"}),t.loading=!1})).catch((function(e){console.log(e),t.loading=!1}))}})},s=c,r=n(1001),u=(0,r.Z)(s,a,i,!1,null,null,null),d=u.exports}}]);