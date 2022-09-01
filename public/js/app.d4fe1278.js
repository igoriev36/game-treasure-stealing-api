(function(){var e={12607:function(e,t,n){"use strict";var o=n(28935),r=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{attrs:{id:"app"}},[n("Header"),n("router-view",{staticClass:"router-view"}),n("Footer")],1)},a=[],s=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"header-section"},[n("div",{staticClass:"container"},[n("nav",{staticClass:"main-menu left-side"},[n("router-link",{attrs:{to:"/"}},[e._v("Home")]),n("router-link",{attrs:{to:"/inventory"}},[e._v("Inventory")])],1),e.isLoggedIn?n("div",{staticClass:"user-coin-info right-side"},[n("span",[e._v(e._s(e.totalSol)+" SOL ("+e._s(e._f("currency")(e.inDollars))+")")]),n("span",[e._v(e._s(e.totalLoot)+" Loot")]),n("el-popover",{attrs:{placement:"bottom",title:"My Account",width:"260",trigger:"click"}},[n("div",{staticClass:"p-row"},[n("label",{staticClass:"block"},[e._v("Wallet Address: ")]),n("strong",[e._v(e._s(e.wallet))]),e._v(" "),n("el-button",{attrs:{icon:"el-icon-copy-document",type:"text"},on:{click:e.copyWallet}})],1),n("div",{staticClass:"p-row"},[n("label",{staticClass:"block"},[e._v("Balance:")]),n("strong",[e._v(e._s(e.totalSol)+" SOL")])]),n("div",{staticClass:"p-row"},[n("el-button",{on:{click:e.logout}},[e._v("Disconnect")])],1),n("el-button",{attrs:{slot:"reference",type:"text",icon:"el-icon-user-solid"},slot:"reference"},[e._v("My Account")])],1)],1):n("div",{staticClass:"user-coin-info right-side"},[n("router-link",{attrs:{to:"/connect-wallet"}},[e._v("Connect Wallet")])],1)])])},i=[],l=n(47010),c=n.n(l),u=n(34665),d=n(98576),m={data(){return{}},mixins:[d.Z],computed:{...(0,u.rn)({wallet:e=>e.users.wallet,wallet_balance:e=>e.users.wallet_balance,user:e=>e.users.user,sol_rate:e=>e.sol_rate}),isPhantom(){return solana?.isPhantom},provider(){return this.getProvider()},...(0,u.Se)({isLoggedIn:"users/isLoggedIn"}),totalSol(){return this.wallet_balance},inDollars(){return this.totalSol*this.sol_rate},totalLoot(){return this.user.total_loot}},methods:{...(0,u.nv)({doLogout:"users/logout"}),async logout(){this.disconnectPhantom(),await this.doLogout(),this.$router.push(`/connect-wallet?redirect=${this.$route.fullPath}`)},copyWallet(){c()(this.wallet),this.$message({message:"Wallet address copied.",type:"success"})},async disconnectPhantom(){console.log(this.provider),this.provider.disconnect()}}},f=m,h=n(1001),g=(0,h.Z)(f,s,i,!1,null,null,null),p=g.exports,E=function(){var e=this,t=e.$createElement;e._self._c;return e._m(0)},T=[function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"footer-section"},[n("div",{staticClass:"container align-center"},[e._v(" (c) 2022 copyright by YourCompany ")])])}],v={data(){return{}}},S=v,w=(0,h.Z)(S,E,T,!1,null,null,null),b=w.exports;o["default"].filter("currency",(function(e){if("number"!==typeof e)return e;var t=new Intl.NumberFormat("en-US",{style:"currency",currency:"USD"});return t.format(e)}));var y={components:{Header:p,Footer:b},computed:{...(0,u.rn)({socket:e=>e.socket})},mounted(){this.socket.on("gts_connect",(function(e){console.log(e)})),this.socket.on("game_update",(function(e){console.log(e)}))}},A=y,N=(0,h.Z)(A,r,a,!1,null,null,null),k=N.exports,O=n(12809);o["default"].use(O.Z);const L=[{path:"/",name:"home",component:()=>n.e(177).then(n.bind(n,91491))},{path:"/login",name:"login",component:()=>n.e(535).then(n.bind(n,22379))},{path:"/connect-wallet",name:"connect-wallet",component:()=>n.e(864).then(n.bind(n,70296))},{path:"/inventory",name:"inventory",component:()=>n.e(234).then(n.bind(n,30365))},{path:"*",redirect:"/404",hidden:!0}],P=()=>new O.Z({scrollBehavior:()=>({y:0}),routes:L}),I=P();function R(){const e=P();I.matcher=e.matcher}var C=I,F=n(26166),D=n.n(F),M=n(74549),G=n.n(M),W=n(60329);const Z="bt_gts_token",U="bt_gts_refresh_token";function H(){return W.Z.get(Z)}function j(e){return W.Z.set(Z,e)}function x(){return W.Z.remove(Z)}function B(){return W.Z.get(U)}function $(e){return W.Z.set(U,e)}function q(){return W.Z.remove(U)}n(92196);const K=D().create({baseURL:"https://games.cryptoquestnft.com/api/v1",timeout:45e3});K.interceptors.request.use((e=>(e.headers["x-app-id"]="123456",ue.getters.token&&(e.headers["Authorization"]=`Bearer ${H()}`),e)),(e=>Promise.reject(e))),K.interceptors.response.use((e=>e.data),(e=>Promise.reject(e)));var Y=K;class Q{login(e){return Y({url:"/auth/login",method:"post",data:e})}connectWallet(e){return Y({url:"/auth/connect-wallet",method:"post",data:e})}refreshToken(e){return Y({url:"/auth/refresh-token",method:"post",data:e})}getInfo(e){return Y({url:"/auth/info?t=u",method:"get",params:e})}logout(){return Y({url:"/auth/logout",method:"post"})}toggleSelectHero(e){return Y({url:"/user/update-hero-status",method:"post",data:e})}updateNonNFTEntries(e){return Y({url:"/user/update-non-nft-entries",method:"post",data:e})}enterGame(e){return Y({url:"/user/enter-game",method:"post",data:e})}getBalanceWallet(e){return Y({url:"/user/get-balance-wallet",method:"post",data:e})}}const z=new Q,J=()=>({queued:!1,game_playing_id:0,game_id:0,token:H(),refresh_token:B(),wallet:"",wallet_balance:0,user:{},non_nft_entries:0,heroes_mint:[],heroes_data:[],curent_game_info:{},submitted:[]}),V=J(),X={heroes(e,t,n){return void 0===n.nfts?[]:_.filter(n.nfts,(t=>e.heroes_mint.indexOf(t.mint)>-1))},isLoggedIn(e){return!!e.token},heroCommitedTotal(e){let t=_.filter(e.heroes_data,(e=>1===e.active));return t.length}},ee={SET_QUEUED:(e,t)=>{e.queued=t},RESET_STATE:e=>{Object.assign(e,J())},SET_TOKEN:(e,t)=>{e.token=t},SET_REFRESH_TOKEN:(e,t)=>{e.refresh_token=t},SET_FULLNAME:(e,t)=>{e.fullname=t},SET_WALLET:(e,t)=>{e.wallet=t},SET_WALLET_BALANCE:(e,t)=>{e.wallet_balance=t},SET_AVATAR:(e,t)=>{e.avatar=t},SET_USER:(e,t)=>{e.user=t},SET_HEROES_MINT:(e,t)=>{e.heroes_mint=t},SET_HEROES_DATA:(e,t)=>{e.heroes_data=t},SET_NON_NFT_ENTRIES:(e,t)=>{e.non_nft_entries=t},SET_CURENT_GAME_INFO:(e,t)=>{V.curent_game_info=t},SET_GAME_PLAYING_ID:(e,t)=>{e.game_playing_id=t},SET_GAME_ID:(e,t)=>{e.game_id=t},SET_SUBMITTED:(e,t)=>{e.submitted=t}},te={login({commit:e},t){const{email:n,password:o}=t;return new Promise(((t,r)=>{z.login({email:n.trim(),password:o}).then((n=>{const{data:o}=n;e("SET_TOKEN",o.token),e("SET_REFRESH_TOKEN",o.refresh_token),j(o.token),$(o.refresh_token),t(n)})).catch((e=>{r(e)}))}))},connectWallet({commit:e},t){const{wallet:n,signature:o}=t;return new Promise(((t,r)=>{z.connectWallet({wallet:n,signature:o,timestamp:(new Date).getTime()}).then((n=>{const{data:o}=n;e("SET_TOKEN",o.token),e("SET_REFRESH_TOKEN",o.refresh_token),j(o.token),$(o.refresh_token),t(n)})).catch((e=>{r(e)}))}))},refreshToken({state:e,commit:t}){return new Promise(((n,o)=>{let r={refresh_token:e.refresh_token};z.refreshToken(r).then((e=>{const{data:o}=e;null!==o.token?(t("SET_TOKEN",o.token),j(o.token)):(x(),q()),n(e)})).catch((e=>{o(e)}))}))},getInfo({state:e,commit:t,dispatch:n}){return new Promise(((e,o)=>{z.getInfo().then((o=>{const{data:r}=o;let a=r.user,s=r.heroes,i=r.heroes_data;t("SET_WALLET",a.wallet),t("SET_USER",a),t("SET_HEROES_MINT",s),t("SET_HEROES_DATA",i),t("SET_NON_NFT_ENTRIES",r.non_nft_entries),t("SET_SUBMITTED",r.submitted),t("SET_CURENT_GAME_INFO",r.current_entries),t("SET_GAME_PLAYING_ID",r.game_playing_id),t("SET_GAME_ID",r.game_id),r.game_playing_id>0&&t("SET_QUEUED",!0),n("getBalanceWallet"),e(r)})).catch((e=>{o(e)}))}))},logout({state:e,commit:t}){return new Promise(((e,n)=>{z.logout().then((()=>{x(),q(),R(),t("RESET_STATE"),e()})).catch((e=>{n(e)}))}))},resetToken({commit:e}){return new Promise((t=>{x(),e("RESET_STATE"),t()}))},toggleSelectHero({state:e,commit:t},n){return new Promise(((o,r)=>{z.toggleSelectHero(n).then((n=>{let r=[];e.heroes_data.forEach((e=>{let t=e;t.mint===n.update.mint&&(t.active=n.update.active),r.push(t)})),t("SET_HEROES_DATA",r),t("SET_CURENT_GAME_INFO",n.user_game_info),o(n)})).catch((e=>{r(e)}))}))},updateNonNFTEntries({commit:e},t){return new Promise(((n,o)=>{z.updateNonNFTEntries({entries:t}).then((t=>{e("SET_CURENT_GAME_INFO",t.user_game_info),n(t)})).catch((e=>{console.log(e),o(e)}))}))},enterGame({commit:e,dispatch:t},n){return new Promise(((o,r)=>{const a={signature:n,timestamp:(new Date).getTime()};z.enterGame(a).then((n=>{e("SET_CURENT_GAME_INFO",n.user_game_info),e("SET_SUBMITTED",n.submitted),t("getBalanceWallet"),o(n)})).catch((e=>{console.log(e),r(e)}))}))},getBalanceWallet({commit:e,state:t}){return new Promise(((n,o)=>{const r={wallet_address:t.wallet};z.getBalanceWallet(r).then((t=>{e("SET_WALLET_BALANCE",t.balance),n(t)})).catch((e=>{console.log(e),o(e)}))}))}};var ne={namespaced:!0,state:V,getters:X,actions:te,mutations:ee};class oe{getGameInfo(){return Y({url:"/game/info",method:"get"})}getNSTF(){return Y({url:"https://cryptoquestnft.com/api/nfts/all",method:"get"})}validAuth(){return Y({url:"/app/valid",method:"post"})}}const re=new oe,ae={sidebar:e=>e.sidebar,device:e=>e.device,token:e=>e.users.token,avatar:e=>e.users.avatar,name:e=>e.users.name};var se=ae;o["default"].use(u.ZP);const ie=n(53969),le=ie("https://games.cryptoquestnft.com/gts.dashboard",{}),ce=new u.ZP.Store({modules:{users:ne},state:{version:"1.0.1",sidebar:!1,device:"",nfts_loading:!1,nfts:[],SolTotal:0,socket:le,game_info:{},node_type:"devnet",sol_rate:1,primary_wallet:""},getters:se,mutations:{SET_NFTS_LOADING:(e,t)=>{e.nfts_loading=t},SET_NFTS_DATA:(e,t)=>{e.nfts=t},SET_SOL_TOTAL:(e,t)=>{e.SolTotal=t},SET_GAME_INFO:(e,t)=>{e.game_info=t},SET_SOL_RATE:(e,t)=>{e.sol_rate=t},SET_PRIMARY_WALLET:(e,t)=>{e.primary_wallet=t},SET_NODE_TYPE:(e,t)=>{e.node_type=t}},actions:{get_game_info({commit:e}){return new Promise(((t,n)=>{re.getGameInfo().then((n=>{e("SET_GAME_INFO",n.game_info),e("SET_SOL_RATE",n.sol_usd_rate),e("SET_PRIMARY_WALLET",n.primary_wallet),e("SET_NODE_TYPE",n.node_type),t(n)})).catch((e=>{console.log(e),n(e)}))}))},valid({commit:e}){return new Promise(((e,t)=>{re.validAuth().then((t=>{e(t)})).catch((e=>{console.log(e),t(e)}))}))},get_nfts({commit:e}){return e("SET_NFTS_LOADING",!0),new Promise(((t,n)=>{re.getNSTF().then((n=>{e("SET_NFTS_DATA",n.nfts),e("SET_NFTS_LOADING",!1),t(n)})).catch((t=>{console.log(t),e("SET_NFTS_LOADING",!1),n(t)}))}))}}});var ue=ce,de=n(97345),_e=n(2228),me=n(39879),fe=n.n(me),he=n(69734),ge=n.n(he);const pe=ge().title||"Treasure Stealing";function Ee(e){return e?`${e} - ${pe}`:`${pe}`}fe().configure({showSpinner:!1});const Te=["/login","/connect-wallet"];C.beforeEach((async(e,t,n)=>{fe().start(),document.title=Ee(e.meta.title);const o=H();if(o)if("/connect-wallet"===e.path)n({path:"/"}),fe().done();else{const t=ue.getters.name;if(t)n();else try{await ue.dispatch("users/getInfo"),n()}catch(r){await ue.dispatch("users/resetToken"),M.Message.error(r||"Has Error"),n(`/connect-wallet?redirect=${e.path}`),fe().done()}}else-1!==Te.indexOf(e.path)?n():(n(`/connect-wallet?redirect=${e.path}`),fe().done())})),C.afterEach((()=>{fe().done()}));var ve=JSON.parse('{"hello":"Hello world!"}');const Se="en",we={en:ve};o["default"].use(de.Z),o["default"].use(u.ZP),o["default"].config.productionTip=!1;const be=Object.assign(we);o["default"].use(G()),o["default"].use(_e.ZP),o["default"].config.productionTip=!1;var ye=new de.Z({locale:Se,fallbackLocale:"en",messages:be});new o["default"]({i18n:ye,store:ue,router:C,render:e=>e(k)}).$mount("#app")},98576:function(e,t,n){"use strict";var o=n(89914);window.Buffer=o.Buffer;const r={methods:{getProvider(){if("phantom"in window){const e=window.phantom?.solana;if(e?.isPhantom)return e}window.open("https://phantom.app/","_blank")}}};t["Z"]=r},69734:function(e){e.exports={title:"Treasure Stealing",fixedHeader:!1,sidebarLogo:!0}}},t={};function n(o){var r=t[o];if(void 0!==r)return r.exports;var a=t[o]={id:o,loaded:!1,exports:{}};return e[o].call(a.exports,a,a.exports,n),a.loaded=!0,a.exports}n.m=e,function(){n.amdO={}}(),function(){var e=[];n.O=function(t,o,r,a){if(!o){var s=1/0;for(u=0;u<e.length;u++){o=e[u][0],r=e[u][1],a=e[u][2];for(var i=!0,l=0;l<o.length;l++)(!1&a||s>=a)&&Object.keys(n.O).every((function(e){return n.O[e](o[l])}))?o.splice(l--,1):(i=!1,a<s&&(s=a));if(i){e.splice(u--,1);var c=r();void 0!==c&&(t=c)}}return t}a=a||0;for(var u=e.length;u>0&&e[u-1][2]>a;u--)e[u]=e[u-1];e[u]=[o,r,a]}}(),function(){n.n=function(e){var t=e&&e.__esModule?function(){return e["default"]}:function(){return e};return n.d(t,{a:t}),t}}(),function(){n.d=function(e,t){for(var o in t)n.o(t,o)&&!n.o(e,o)&&Object.defineProperty(e,o,{enumerable:!0,get:t[o]})}}(),function(){n.f={},n.e=function(e){return Promise.all(Object.keys(n.f).reduce((function(t,o){return n.f[o](e,t),t}),[]))}}(),function(){n.u=function(e){return"js/"+{177:"home",234:"inventory",535:"login",864:"connect-wallet"}[e]+"."+{177:"d412d083",234:"a1cbe727",535:"04505746",864:"1dc5c87c"}[e]+".js"}}(),function(){n.miniCssF=function(e){}}(),function(){n.g=function(){if("object"===typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(e){if("object"===typeof window)return window}}()}(),function(){n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)}}(),function(){var e={},t="game-treasure-stealing-vue:";n.l=function(o,r,a,s){if(e[o])e[o].push(r);else{var i,l;if(void 0!==a)for(var c=document.getElementsByTagName("script"),u=0;u<c.length;u++){var d=c[u];if(d.getAttribute("src")==o||d.getAttribute("data-webpack")==t+a){i=d;break}}i||(l=!0,i=document.createElement("script"),i.charset="utf-8",i.timeout=120,n.nc&&i.setAttribute("nonce",n.nc),i.setAttribute("data-webpack",t+a),i.src=o),e[o]=[r];var _=function(t,n){i.onerror=i.onload=null,clearTimeout(m);var r=e[o];if(delete e[o],i.parentNode&&i.parentNode.removeChild(i),r&&r.forEach((function(e){return e(n)})),t)return t(n)},m=setTimeout(_.bind(null,void 0,{type:"timeout",target:i}),12e4);i.onerror=_.bind(null,i.onerror),i.onload=_.bind(null,i.onload),l&&document.head.appendChild(i)}}}(),function(){n.r=function(e){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})}}(),function(){n.nmd=function(e){return e.paths=[],e.children||(e.children=[]),e}}(),function(){n.p="/"}(),function(){var e={143:0};n.f.j=function(t,o){var r=n.o(e,t)?e[t]:void 0;if(0!==r)if(r)o.push(r[2]);else{var a=new Promise((function(n,o){r=e[t]=[n,o]}));o.push(r[2]=a);var s=n.p+n.u(t),i=new Error,l=function(o){if(n.o(e,t)&&(r=e[t],0!==r&&(e[t]=void 0),r)){var a=o&&("load"===o.type?"missing":o.type),s=o&&o.target&&o.target.src;i.message="Loading chunk "+t+" failed.\n("+a+": "+s+")",i.name="ChunkLoadError",i.type=a,i.request=s,r[1](i)}};n.l(s,l,"chunk-"+t,t)}},n.O.j=function(t){return 0===e[t]};var t=function(t,o){var r,a,s=o[0],i=o[1],l=o[2],c=0;if(s.some((function(t){return 0!==e[t]}))){for(r in i)n.o(i,r)&&(n.m[r]=i[r]);if(l)var u=l(n)}for(t&&t(o);c<s.length;c++)a=s[c],n.o(e,a)&&e[a]&&e[a][0](),e[a]=0;return n.O(u)},o=self["webpackChunkgame_treasure_stealing_vue"]=self["webpackChunkgame_treasure_stealing_vue"]||[];o.forEach(t.bind(null,0)),o.push=t.bind(null,o.push.bind(o))}();var o=n.O(void 0,[998],(function(){return n(12607)}));o=n.O(o)})();