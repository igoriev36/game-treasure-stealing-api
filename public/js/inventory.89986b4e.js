"use strict";(self["webpackChunkgame_treasure_stealing_vue"]=self["webpackChunkgame_treasure_stealing_vue"]||[]).push([[234],{365:function(e,t,r){r.r(t),r.d(t,{default:function(){return f}});var s=function(){var e=this,t=e.$createElement,r=e._self._c||t;return r("div",{staticClass:"inventory-layout"},[r("div",{staticClass:"container"},[r("h1",[e._v("Inventory ("+e._s(e.total)+")")]),r("div",{staticClass:"heroes-wrapper mb-30"},e._l(e.heroes_data,(function(e){return r("HeroItem",{key:e.mint,attrs:{hero:e}})})),1)])])},a=[],n=r(4665),o=function(){var e=this,t=e.$createElement,r=e._self._c||t;return r("div",{staticClass:"inventory-hero-item"},[r("div",{staticClass:"hero-img"},[r("img",{directives:[{name:"lazy",rawName:"v-lazy",value:e.hero_img,expression:"hero_img"}]})]),r("h3",{staticClass:"hero-name"},[e._v(e._s(e.hero_name))]),r("div",{staticClass:"block"},[r("span",[e._v("Hero Tier: "),r("strong",[e.hero_tier?r("span",[e._v(e._s(e.hero_tier))]):r("span",[e._v("None")])])])]),r("div",{staticClass:"block-flex"},[r("span",[e._v("SP: "),r("strong",[e._v(e._s(e.hero.info.stat_points))])]),e._v(" "),r("span",[e._v("CP: "),r("strong",[e._v(e._s(e.hero.info.cosmetic_points))])])])])},i=[],l={data(){return{heroStatus:!1}},props:{hero:{default:()=>{},type:Object}},computed:{meta(){return _.last(this.hero.info.meta)},token_adress(){return this.hero.mint},hero_name(){return this.hero.info.TokenName.token_name},hero_img(){return this.meta.image_url},hero_tier(){return this.hero.info.hero_tier}},methods:{}},h=l,u=r(1001),m=(0,u.Z)(h,o,i,!1,null,null,null),c=m.exports,v={data(){return{}},components:{HeroItem:c},computed:{...(0,n.rn)({heroes_data:e=>e.users.heroes_data}),total(){return this.heroes_data.length}}},d=v,p=(0,u.Z)(d,s,a,!1,null,null,null),f=p.exports}}]);