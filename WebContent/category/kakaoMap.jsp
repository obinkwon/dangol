<div id="map" style="width:100%;height:350px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d9fd572bbbe828231a9aae53eb84ac9a"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(${store.slatitude}, ${store.slongitude}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${store.slatitude}, ${store.slongitude}); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});
// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);
</script>