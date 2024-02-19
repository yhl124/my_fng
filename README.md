# my_fng
플러터를 사용해 Fear and greed index를 확인하는 앱 제작

## 설명

1. 구성 
   - https://edition.cnn.com/markets/fear-and-greed 에서 제공하는 것처럼 지수가 0일 때 바늘이 -90도, 100일 때 90도를 가리키게 함
  ![cnnfnb](<./readme/스크린샷 2024-02-20 오전 2.10.39.png>)
   - 각 시점을 버튼으로 만들어 버튼을 누를 때마다 애니메이션이 적용된 바늘이 부드럽게 움직이게 함

2. 애니메이션
   - Tween을 사용하여 현재값 -> 새로운 값에 따라 바뀌게 함
   - Curves.easeInOut를 사용

3. api : Rapid API에서 제공하는 api사용
        https://rapidapi.com/rpi4gx/api/fear-and-greed-index

<video controls src="/readme/Simulator Screen Recording - iPhone 15 Pro - 2024-02-20 at 02.24.13.mp4" title="Title"></video>