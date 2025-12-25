'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "cb038f6d61a11884f32734f683abcad9",
"version.json": "b2972feac5b61b216f131287f23688f0",
"index.html": "851be7e684c6bb59e0817f418d51a79b",
"/": "851be7e684c6bb59e0817f418d51a79b",
"main.dart.js": "3807059a0e459857ea05b56bbf8f4506",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "2a360ec6b906f8bc4dcd3024bf00093e",
"assets/NOTICES": "17ca150501977fe99240a4b6d801713b",
"assets/FontManifest.json": "67a28da3784fc091c2f816d615fbf08a",
"assets/AssetManifest.bin.json": "242d64e6919d1171404d0965f81dec04",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "cbcb47ebf5ba68136b27269be52af874",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "262525e2081311609d1fdab966c82bfc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "17e9aa846c5f1fd2ebf555a39220a8ee",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "63bb89f52db3abdb3b5c2b7ded7d6e05",
"assets/fonts/MaterialIcons-Regular.otf": "e32ec6b7b96ff0c8bd6c77c4ef2ab4c5",
"assets/assets/NCCL5_HWL_certificate_1.pdf": "4e5de842d2fc4a50221140488bb2c39e",
"assets/assets/images/wallet_2.png": "59eabd8bf6c28e9a4bb399c501150ec1",
"assets/assets/images/comic7.png": "e820202cb139e1edcd0dc400db910828",
"assets/assets/images/jade3.PNG": "6021c691f09787afc980b083737f5233",
"assets/assets/images/partnermain.PNG": "4d4dd95b053a09c9a8effa73f7c589f6",
"assets/assets/images/Soul-Login-Phone.png": "8663c246030f730b1887e2b24cbfe79e",
"assets/assets/images/digicraft_main.png": "5bda3165b834c945820d15fe23df5e6c",
"assets/assets/images/jade2.PNG": "0f5e92895e7c1e2cd5b80eb3cbada9a4",
"assets/assets/images/comic6.png": "b8f5e55fc8a0da65c4303d73bc8b960e",
"assets/assets/images/wallet_3.png": "b60626b0e97ebcd96bfd0c72894363a3",
"assets/assets/images/arfi_6.png": "339929629afdb3e5fa6e8d8f0bd37eb6",
"assets/assets/images/tiger_main.png": "93d6dc80d9a2c2c86070ffaa4d3311ed",
"assets/assets/images/hrm_4.png": "2ff4663ea35d81588ed7193bd3ee16b9",
"assets/assets/images/Soul-Onboarding-gender.png": "483e4f9bd5bdcf9f28a20368f7f64178",
"assets/assets/images/arfi_4.png": "a7de752fa981afea1b6e74372c3c9d0e",
"assets/assets/images/wallet_1.png": "e2137c18cc63f3f3ca7dfa93039c7b00",
"assets/assets/images/comic4.png": "fa89c6756a11ee878986c30a04d20e5d",
"assets/assets/images/jademain.PNG": "52e85310be2acfdfc42e3c7a5eb5556e",
"assets/assets/images/comic5.png": "86eb4f53c8cf0e6dd4591c019b616b02",
"assets/assets/images/jade1.PNG": "953d06bcc06d1fe3ee82d6706acabe57",
"assets/assets/images/arfi_5.png": "16526aad3490984b318510efd271fa19",
"assets/assets/images/hrm_5.png": "838ca6b3d82bec8e39cdc67ed0fd0b19",
"assets/assets/images/hrm_1.png": "304567fe9f75ebe155832418bb6daf62",
"assets/assets/images/jade5.PNG": "0c4c7c3b1fba3322238e33f88e984980",
"assets/assets/images/comic1.png": "65f999c3a58026d069b858df555de14b",
"assets/assets/images/arfi_1.png": "c7147f41a166c7a21493e637d09dd6f9",
"assets/assets/images/wallet_4.png": "25389301ba24d11e493d0253133ac78e",
"assets/assets/images/comicmain.jpg": "29a065fb6da564817b0f6324c3713337",
"assets/assets/images/wallet_5.png": "2cc09d09388ec9776e77360cf64ac15c",
"assets/assets/images/jade4.PNG": "d30bbeedb918523513455836bde861cf",
"assets/assets/images/hrm_2.png": "152be461b2b9bf6397b2c094bd5b4943",
"assets/assets/images/comic2.png": "ce38768dd8c77b4170ddd4ccbe81c52f",
"assets/assets/images/jade6.PNG": "6d655022290b10567f53a3850a29fc67",
"assets/assets/images/arfi_2.png": "9ee2064c150b4fb71300937fd66cbd53",
"assets/assets/images/arfi_3.png": "43c3301936d64dc7dc3a7ab7a51d7a2d",
"assets/assets/images/comic3.png": "6531d08db32af45ee773908808a7e03d",
"assets/assets/images/gymmain.png": "ad17a45959a9b4d66d4e29d2126b1c11",
"assets/assets/images/hrm_3.png": "980340e00305e1593f6592a31f127260",
"assets/assets/images/gym5.png": "89f1cb4dfc4be24a9ed0869803c5fca6",
"assets/assets/images/partner2.png": "579bbf765e9a02d66812b09dfbdcc4c6",
"assets/assets/images/moveon4.PNG": "443d8d7a8855d8d1c0f7cdcce780e80f",
"assets/assets/images/moveon11.PNG": "4b7346c1be0927b39c6b0a4c93a0bd1e",
"assets/assets/images/vendor1.png": "4e420749177f0a66217a855e8ba1600e",
"assets/assets/images/moveon10.PNG": "6a569a6286b8039aaa3cc7791e20ac2e",
"assets/assets/images/zcultures_main.png": "72009bc5558de57903e0d7acf23ca04e",
"assets/assets/images/moveon5.PNG": "3765d5b95ba5ab398b0d33ce1954ce46",
"assets/assets/images/infinity_main.jpg": "834d4d83375d91271a87932db6efdfb4",
"assets/assets/images/partner3.png": "4aed04f46bdceefe0f7155145bb20a4d",
"assets/assets/images/gym4.png": "4baec9a15526026130ae4bae192be71e",
"assets/assets/images/partner1.PNG": "4ff25b0ef199ecd5953e417afd01a07b",
"assets/assets/images/moveon7.PNG": "ba4cc9af3463205651cac0c88390d71e",
"assets/assets/images/vendor3.png": "d94c195f1bc828383edc8c34620f9087",
"assets/assets/images/vendor2.png": "9c17d4c93ed21ad4bdc13300886988ff",
"assets/assets/images/moveon6.PNG": "e0af7cc0d9e01a0da38eebd01792e859",
"assets/assets/images/gym3.png": "a248d06443f03d5b6b72da8cefbcc15b",
"assets/assets/images/partner4.png": "cb5cd4bb67855d45c98d5d01194a9714",
"assets/assets/images/moveon2.PNG": "f9d5bf010f641e466f1ceb68f4b51e66",
"assets/assets/images/moveon3.PNG": "300e953ea0c939fb8c80b471bda4c6e5",
"assets/assets/images/gym2.png": "a9c895bc82e1e59568bb61dac2be744d",
"assets/assets/images/hi5main.png": "d86ed36180b3e49988fb697d340eb72b",
"assets/assets/images/moveon1.PNG": "8278da4dfd1049b830415ecdb797950a",
"assets/assets/images/vendor4.png": "b96f64e056f03a79e494d42857241e12",
"assets/assets/images/gym1.png": "51224fbfda6e77c51754727fa6190ff7",
"assets/assets/images/dr_rej_main.png": "595c8cf2dcaeea1df6f5d1b06f8a9468",
"assets/assets/images/zcul_6.png": "70d29467f0d8ec880a448b95fc5e0072",
"assets/assets/images/hrm_main.png": "8c9b425fc58630bd887badaf83045c17",
"assets/assets/images/suzuki_5.png": "f4ca0995b9cf74d8b01ba721db4ab75b",
"assets/assets/images/zcul_4.png": "ecbc07724e22314bee83915af396b21c",
"assets/assets/images/zcul_5.png": "f947c31fd4291caea73a0ac9475cde3e",
"assets/assets/images/suzuki_4.png": "d7b2b70fa91980308ee2f2e43fb5f953",
"assets/assets/images/hi54.png": "8d65743e443a010e02f02ed5609cb2c7",
"assets/assets/images/pp.png": "ac0e38d4c5d2e90df6bf1714779069ed",
"assets/assets/images/zcul_1.png": "cc4d5a0c971c8d492dc69e2d32ff60ab",
"assets/assets/images/suzuki_1.png": "44d75d1bad5f24ee37deda4694ba36dc",
"assets/assets/images/hi51.png": "4129d6f2048b8954448aaf3397aba7e7",
"assets/assets/images/agency_main.png": "2accc99213d391e3929a281558101c87",
"assets/assets/images/Soul-Match.png": "27f73b7bfa9e9965d74d28fdbb4c625e",
"assets/assets/images/moveon8.PNG": "99f8007b227eab5873a7345bd5482642",
"assets/assets/images/hi53.png": "bc21c8e935eda8f41bb2e7194271f7cc",
"assets/assets/images/zcul_2.png": "969d61009dbaf370ff5707f1751457ef",
"assets/assets/images/suzuki_3.png": "5acd078be90cee447515c25048c102b1",
"assets/assets/images/suzuki_2.png": "ef2e1cc7e0188462fc35485a1cec38bd",
"assets/assets/images/zcul_3.png": "a97483ed9da1069eb431fe8bf68f6a90",
"assets/assets/images/hi52.png": "a682048518f1b4af809075e70e36ec27",
"assets/assets/images/moveon9.PNG": "40339d0eac7204f1fcc09bb2880b4de6",
"assets/assets/images/weday_main.png": "c499ade45fd7b8dabd7d04e897a3f8f2",
"assets/assets/images/Soul-Sign-up.png": "de91a993af20e3d17bc61bcb3194d98f",
"assets/assets/images/agency2.png": "b671c504b4259d4101df786c84b1038d",
"assets/assets/images/suzuki_main.png": "21a8087f452d37b8ea31de25fbeb9462",
"assets/assets/images/tiger_3.png": "54e821cab76a23badd9e7746a4990750",
"assets/assets/images/weday_2.png": "f1bc977ef5cdacdc694e053572998262",
"assets/assets/images/infinity_2.png": "ed5422ab28974b41225f435c95b984e6",
"assets/assets/images/infinity_3.png": "12f1c4570d8d3a547dd3cf88ef6c7384",
"assets/assets/images/weday_3.png": "5a38ee485836860d083da9519bbe7c94",
"assets/assets/images/tiger_2.png": "d242ae0b1703918ee028e64a208a8717",
"assets/assets/images/agency3.png": "5510d7a02cfdd5551b223707e7d203d0",
"assets/assets/images/digi_4.png": "7c9dce48eeb09e0ba93fb45236fba5b7",
"assets/assets/images/arfi_main.png": "ea71a8b417bbcaca33d03ca8f6d1e30b",
"assets/assets/images/agency1.png": "952e33250bd9531a81a0e020af45395b",
"assets/assets/images/weday_1.png": "8bd466e775bfc2db5d115c7dde422d97",
"assets/assets/images/rider5.png": "eadc60acc77c204be2be9d56b25ccbe0",
"assets/assets/images/infinity_1.png": "d29d8f1491d6d00e9d6f366daef21f1f",
"assets/assets/images/rider4.png": "9357a1762cc14943d50be096124843a9",
"assets/assets/images/tiger_1.png": "3220cba47a028824c2cb251988673ac6",
"assets/assets/images/digi_5.png": "37d12cfc599dca21bdf92fa797323bb1",
"assets/assets/images/Soul-Non-match-User-view.png": "e22be8f21bde58667dde08094e894ffb",
"assets/assets/images/digi_1.png": "cb844a1204422fd108c79a99ecc225c4",
"assets/assets/images/agency4.png": "73644663465f1311ff253b13694e2ee2",
"assets/assets/images/tiger_5.png": "5f30f97d4bf3f47a5abf31a93c87e165",
"assets/assets/images/infinity_4.png": "1f7637346d527d81674bf8c04b0cc9bd",
"assets/assets/images/weday_4.png": "845678d0546595531a1081c712127eff",
"assets/assets/images/rider1.png": "bdf78d2d9c6923aaf850645a69510fc2",
"assets/assets/images/weday_5.png": "ed6116fc3c7bd30a44a333b0f21dc36a",
"assets/assets/images/infinity_5.png": "3b21e892d5f34ea6c09c612b3af36bff",
"assets/assets/images/tiger_4.png": "efef2e26ab8003de7590d83395f3db9f",
"assets/assets/images/pp2.png": "85013db37d3b2b62b6ecfed2399a2ddd",
"assets/assets/images/IMG_8297.png": "583c8a8ec006b84ec51fd359fcd76638",
"assets/assets/images/me_profile.png": "dbbaad9ab98b860887383fe0ddbe0bcb",
"assets/assets/images/digi_2.png": "b1b1433a1426caee338a959e0b9a30b7",
"assets/assets/images/rider3.png": "0e68f288234a8ec75eb6f23102a57dc0",
"assets/assets/images/rider2.png": "412e47ac2eaf88a675ff04bc1c238ade",
"assets/assets/images/infinity_6.png": "45c316efe9f99fcd2d87633aaf073802",
"assets/assets/images/Soul-Feed.png": "0b2d93269a40af87430adaf74d6e3897",
"assets/assets/images/pp1.png": "7d3acf0c419f149157e12c1d8c627451",
"assets/assets/images/digi_3.png": "73e1f08a2cd9845f027d22565ddff66a",
"assets/assets/Resume(Tin).pdf": "d17d6df97d13f449c867f581389b12f5",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
