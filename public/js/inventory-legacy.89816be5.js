"use strict";(self["webpackChunkgame_treasure_stealing_vue"]=self["webpackChunkgame_treasure_stealing_vue"]||[]).push([[234],{30365:function(e,t,n){n.r(t),n.d(t,{default:function(){return g}});var r=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"inventory-layout"},[n("div",{staticClass:"container"},[n("h1",[e._v("Inventory ("+e._s(e.total)+")")]),n("div",{staticClass:"heroes-wrapper mb-30"},e._l(e.heroes_data,(function(e){return n("HeroItem",{key:e.mint,attrs:{hero:e}})})),1)])])},s=[],o=n(93019),a=n(34665),i=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"inventory-hero-item"},[n("div",{staticClass:"hero-img"},[n("img",{directives:[{name:"lazy",rawName:"v-lazy",value:e.hero_img,expression:"hero_img"}]})]),n("h3",{staticClass:"hero-name"},[e._v(e._s(e.hero_name))]),n("div",{staticClass:"block"},[n("span",[e._v("Hero Tier: "),n("strong",[e.hero_tier?n("span",[e._v(e._s(e.hero_tier))]):n("span",[e._v("None")])])])]),n("div",{staticClass:"block-flex"},[n("span",[e._v("SP: "),n("strong",[e._v(e._s(e.hero.info.stat_points))])]),e._v(" "),n("span",[e._v("CP: "),n("strong",[e._v(e._s(e.hero.info.cosmetic_points))])])])])},u=[],l={data:function(){return{heroStatus:!1}},props:{hero:{default:function(){},type:Object}},computed:{meta:function(){return _.last(this.hero.info.meta)},token_adress:function(){return this.hero.mint},hero_name:function(){return this.hero.info.TokenName.token_name},hero_img:function(){return this.meta.image_url},hero_tier:function(){return this.hero.info.hero_tier}},methods:{}},h=l,c=n(1001),m=(0,c.Z)(h,i,u,!1,null,null,null),v=m.exports,f={data:function(){return{}},components:{HeroItem:v},computed:(0,o.Z)((0,o.Z)({},(0,a.rn)({heroes_data:function(e){return e.users.heroes_data}})),{},{total:function(){return this.heroes_data.length}})},d=f,p=(0,c.Z)(d,r,s,!1,null,null,null),g=p.exports}}]);