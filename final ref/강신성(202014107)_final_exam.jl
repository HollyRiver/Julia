### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ eb84366e-62e9-445a-9eab-9f7900dc329c
using PlutoUI

# ╔═╡ 771b13aa-2bdd-400a-87e3-cc5bae383cfe
md"""
# 15wk-2: 기말고사
"""

# ╔═╡ 59a4e707-7e30-43ac-8c8c-6103740384c1
md"""
#### 202014107 / 통계학과 / 강신성
"""

# ╔═╡ e3e0fdec-5d82-4033-a258-1c5ed19f1174
PlutoUI.TableOfContents()

# ╔═╡ 3a89c770-a071-4d46-bff3-57e54008f6e8
md"""
## 1. SVD
"""

# ╔═╡ 8f8f60db-9082-47a5-8de0-60f11572afcd
md"""
통계학에서 SVD는 어떻게 활용될 수 있는가? 활용분야를 목록화하고 간단히 서술하라. 
"""

# ╔═╡ e3143411-c941-4216-bce2-ed79cd9b318f
md"""
##### **A. 주성분분석과 주성분회귀**

> * design matrix $\bf X_{n\times p}$의 SVD를 이용하면 적당한 직교변환을 수행하여 원래의 행렬로 복원할 수 있는 행렬을 만들 수 있다. 이 행렬의 각 열을 주성분이라고 하고, 이 행렬을 이용하여 분석하는 기법을 주성분분석이라고 한다.
>
> * 주성분분석은 design matrix 자체를 활용하는 것보다 차원이 축소된다는 점, 변수 간 직교하는 형태로 만들어 다중공선성을 해소시켜준다는 점에서 유리하다. 특히, 다중공선성이 있는 상황에서 주성분회귀로 추정된 회귀계수의 MSE가 최소제곱추정량의 MSE보다 작다는 점에서 유용하다.

---

##### **B. 회귀분석에서의 활용**

> * design matrix의 SVD는 회귀분석의 계수를 구할 때에 활용할 수도 있다. 이 경우, 특이값의 역수를 이용하여 역행렬을 계산한다. 설명변수 간 선형종속 관계가 있을 경우 0으로 산출되는 특이값을 역수를 취하지 않고 그대로 사용하는 일반화역행렬의 꼴을 이용하여 회귀계수를 추정할 수 있다는 점에서 범용성이 크다.

---

##### **C. 통계적 이론의 이해 및 증명의 기반**

> * 행렬의 SVD표현은 그 자체로는 해석하기 어려운 수식이나 변수들의 기댓값, 분산, 편향제곱합 등을 알기 쉽게 재표현하거나, 선형변환을 분해하여 직관적으로 해석할 수 있게 만들어주기도 한다. 이는 통계적 이론들을 수식으로써 체감할 수 있게 만들고, 나아가 증명의 수단으로서 활용할 수 있다는 점에서 유용하다.

---
"""

# ╔═╡ aa306e3f-6e9a-413c-8e75-22f49fbc150a
md"""
## 2. 다중공선성
"""

# ╔═╡ 9bf50bb3-350c-4edd-9a9f-a41c0fc865c2
md"""
토익,텝스,학점을 설명변수 ${\bf X}_{n \times 3}$ 로 설정하고 이를 바탕으로 연봉 ${\bf y}_{n\times 1}$를 추정하고자 한다. (이때 학생들의 토익과 텝스점수는 서로 비슷하다고 가정한다. 즉 토익점수가 높은 학생은 대체로 텝스점수도 높으며, 반대의 경우도 그러하다고 가정한다) 다음을 잘 읽고 물음에 답하라. 
"""

# ╔═╡ 51e8f9e3-b7d4-4e78-8b92-a26af54cda8b
md"""
(1) 선형회귀를 사용하여 계수(토익,텝스,학점이 연봉에 미치는 영향)를 추정하고자 한다. 이러한 상황은 그림1에서 무엇과 관련이 있는가? 왜 그렇다고 생각하는가? 
"""

# ╔═╡ 6d14b11f-0f77-470a-9512-63fad98dd79a
md"""
![](https://www.kdnuggets.com/wp-content/uploads/arya_biasvariance_tradeoff_5.png)
ref: <https://www.kdnuggets.com/2022/08/biasvariance-tradeoff.html>
"""

# ╔═╡ abb7f95d-75c3-4463-88fe-9fb66ae086fe
md"""

**<답>**

* 주어진 자료에 대해서 선형회귀로 계수를 추정하는 것은 네 번째 그림(X표시들의 중심은 과녁의 중앙이지만, 퍼진 정도가 큰 그림)과 관련이 있다.


* 토익, 텝스, 학점 세 개의 설명변수만이 연봉의 결정에 관여한다고 가정하자. 이 때, 토익과 텝스점수는 서로 비슷하므로 다중공선성의 문제가 발생하게 된다.


* 최소제곱추정량은 unbiased estimator이므로 평균적으로 모수값을 추종하겠지만, 다중공선성이 있는 경우 분산이 상당히 커지게 된다.


* 결론적으로, 선형회귀를 사용하여 토익, 텝스, 학점이 연봉에 미치는 영향을 추정할 때 회귀계수는 모수를 중심으로 하지만, 분산은 상당히 큰 정규분포를 따르게 된다. 산출된 추정량을 과녁의 X표시에 대응하고, 추정할 모수를 과녁의 중앙에 대응할 때, X표시들의 중심은 과녁의 중앙이지만 퍼진 정도가 상당히 큰 상황이라고 여길 수 있다. 따라서 우측 아래의 High Variance / Low Bias인 그림과 관련이 있다고 생각했다.

---
"""

# ╔═╡ e069c354-8ee3-4490-8937-25a665f0ce54
md"""
(2) 능형회귀를 이용하여 계수를 추정한다고 하자. 여기에서 $\lambda$는 어떠한 역할을 하는가? 그림과 연관시켜 설명하라.
"""

# ╔═╡ 748e2cdf-79ce-43d9-b37b-1427beb4e4ba
md"""
**<답>**

* 그림을 왼쪽에서 오른쪽, 위에서 아래 방향으로 1, 2, 3, 4라 번호를 매길 때, 능형회귀에서 $\lambda$의 값이 커짐에 따른 양상은 4, 2, 1의 순서로 대응할 수 있다.

![](https://github.com/HollyRiver/Julia/blob/main/final%20ref/ref_KDnuggets_The%20Bias%20Variance%20Trade%20off.jpg?raw=true)

* 능형회귀는 일반적인 최소제곱추정량의 손실함수에 L2 패널티를 추가한 모형이다. L2 패널티는 계수의 절대값이 커짐에 따라 같이 커지므로, 계수를 $0$ 근처로 추정하게 만들어 분산을 줄이는 효과를 준다. 여기서 $\lambda$는 이 패널티항의 영향력을 조절하는 역할을 한다. 이 값이 작다면 분산이 커지고, $\lambda = 0$이라면 최소제곱추정량의 분산과 동일하게 된다. 반대로 $\lambda$가 크다면, 분산은 줄어들지만 모형은 계수를 $0$ 근처로 작게 만드는 것에만 더 집중하게 되어 편향이 커지게 된다.


* 3번째 그림의 경우(High Variance / Low Bias) X표시들의 중심이 과녁의 중심과 비슷하지만 분산이 상당히 크다. 즉, 해당 그림은 $\lambda$의 값이 가장 작은 상황이라고 볼 수 있다.


*  $\lambda$를 더 키우게 되면 추정량이 안정적이므로 X표시들이 흩어진 정도는 줄어들겠으나, 추정해야 할 모수인 과녁 중앙에는 멀어지게 된다고 볼 수 있다. 이에 따라 $\lambda$를 너무 크게 설정하면 1번 그림처럼(Low Variance / High Bias) 추정량이 모수와 차이가 나게 된다.


* 가장 좋은 것은 추정량의 분산이 너무 크지 않으면서, 모수와의 차이도 얼마 나지 않는 것이다. 즉, 2번 그림처럼(Low Variance / Low Bias) X표시들이 많이 흩어지지도 않고, 과녁의 중앙과도 가까운 상황이 가장 이상적이다. 따라서 능형회귀에서는 가장 적당한 $\lambda$값을 찾는 것이 최우선적인 목표라고 볼 수 있다.

---

"""

# ╔═╡ ad99f90c-512f-450e-89e5-3283b6d68a57
md"""
(3) 주성분 회귀 (Principal component regression, PCR)을 이용하여 계수를 추정하고자 한다. 이때 principle componet 수를 작게 설정할때와 크게 설정할때 어떠한 일이 생기는지 설명하라.
"""

# ╔═╡ b22ca67a-85c7-4de0-992b-3846d185e725
md"""
**<답>**

* 주성분(Principle Component)의 수가 작게 설정된다는 것은 데이터의 차원을 줄여서 분석한다는 것이다. 이경우 특이값이 큰 일부만 택하기 분산이 작아지는 효과가 있지만, 주성분이 너무 작으면 기존 데이터가 가지는 정보를 충분히 포함하지 않게 되어 모수와 추정량 간 편향이 커질 수 있다. 극단적으로 $0$개의 주성분만 고려한다면 모든 계수가 $0$이 되어 분산이 $0$이지만 편향은 최대가 된다. 이는 계수값 없이 연봉의 평균을 예측치로 내놓는 모형과 동일할 것이다.


* 반대로 주성분의 수가 크게 설정되면 데이터의 차원을 최대한 유지하게 된다. 이 경우, 모수와 추정량 간 편향은 줄어들겠지만, 작은 특이값도 사용하여, 추정량의 분산이 커지게 된다. 토익과 텝스, 학점만이 연봉에 관여한다고 가정할 때, 극단적으로 모든 주성분을 고려하면 다중공선성이 있는 상황에서 분산이 엄청나게 커지고 편향은 $0$이 된다. 이때 주성분회귀의 결과는 최소제곱추정량을 이용한 모형과 동일하게 된다.

---
"""

# ╔═╡ 734e8d32-55de-4eaf-8498-10c9e9f2e51f
md"""
(4) 능형회귀에서 $\lambda=0$ 으로 설정하거나 $\lambda = \infty$로 설정하는 것이 어떠한 의미를 가지는 주성분 회귀와 연결시켜 설명하라.
"""

# ╔═╡ b45fd6f2-c06d-4823-9729-856d6dfd225e
md"""
**<답>**

`(2)`와 `(3)`에서 기술한 내용을 기반으로 아래와 같이 설명할 수 있다.

*  $\lambda = 0$으로 설정하면, 최소제곱추정량을 사용하는 회귀모형과 동일하다. 이것은 주성분을 모두 사용하는 주성분 회귀의 결과와 일치하다.

*  $\lambda = \infty$로 설정하면, 능형회귀의 손실함수에서 L2 패널티가 무한대로 커져 회귀계수는 모두 $0$으로 수렴하게 된다. 이는 예측값이 평균과 동일한 모형과 같으며, $0$개 주성분만 고려하는 주성분회귀의 결과와 일치하다.

---
"""

# ╔═╡ 14c22744-c549-4fac-84e0-7f913f1cfa58
md"""
## 3. 면접질문?
"""

# ╔═╡ ddd0c1bd-19fe-45ab-893b-c94242d612c0
md"""
(1) 능형회귀에 대하여 간단히 설명하라. 
"""

# ╔═╡ 52a5dbb8-b2e8-4b67-bac6-8223b48153b5
md"""
**<답>**

* 능형회귀는 최소제곱법 손실함수에 L2 패널티항을 추가한 회귀모형이다.
* L2 패널티는 계수의 값이 커짐에 따라 그 값이 커지므로, 계수를 $0$ 근처로 추정하게 만들어 분산이 줄어드는 효과를 준다.
* 이로 인해 능형회귀는 다중공선성이 있는 상황에서 최소제곱법에 의한 회귀모형보다 신뢰할 수 있는 추정치를 제공하고, 오버피팅을 방지한다는 점에서 모델의 성능을 향상시킨다.

---
"""

# ╔═╡ a329cfda-d89c-49e0-9f0e-59d2cad465d5
md"""
(2) 다중공선성이란 무엇이며 어떤 문제를 일으키는 간단히 서술하라.
"""

# ╔═╡ f940af15-906e-4878-80a5-6202ad4ab1f2
md"""
**<답>**

* 다중공선성이란 설명변수 간 선형 상관관계가 큰 것을 의미한다.
* 최소제곱법에 의한 회귀모형에서 다중공선성이 존재하면 산출된 계수값을 그대로 받아들일 수 없고, 설명변수 간 종속관계를 이해하여 해석해야 한다. 이러한 점에서 해석이 불가능하거나 어려운 계수값을 모형이 추정한다는 문제를 일으킨다.
* 또한 추정량의 분산이 상당히 커져 작은 오차에도 계수값이 크게 바뀔 수 있다. 이에 따라 모형이 새로운 데이터로 예측을 수행할 때 오버피팅의 문제가 발생할 수 있다.

---
"""

# ╔═╡ 88d2172a-9df3-454d-ae8b-290a069a6d27
md"""
(3) ${\bf X}_{n\times p}$, $p>2$ 일 경우 ${\bf X}$를 시각화하는 방법에 대하여 간단히 서술하라.
"""

# ╔═╡ a6855040-d2b7-4a94-a91e-9b707f3b6405
md"""
**<답>**

* 설명변수가 많을 경우 주성분분석을 통해 $\bf X$를 재표현함으로써 2차원 평면에 시각화할 수 있다.
*  $\bf X$의 2개 주성분만 고려하면 직교하는 두 축에 대한 평면을 기준으로 데이터를 눌러주는 효과가 있다. 이렇게 변환된 변수들을 축으로 사용하면 데이터를 직관적으로 시각화할 수 있다.

---
"""

# ╔═╡ 5d1a6abd-3075-4b7f-95a8-2a4101a81185
md"""
(4) 직교변환이 가지는 의미를 간단히 서술하라.
"""

# ╔═╡ 4820c00c-ddb0-45bf-9cfe-699f1843e440
md"""
**<답>**

* 벡터들에 직교변환을 적용해도 그 벡터들은 크기와 각도가 보존된다. 따라서 데이터를 의미하는 행렬에 직교변환을 수행하는 것은 데이터를 바라보는 관점을 변화시키는 것이라고 볼 수 있다.

---
"""

# ╔═╡ e775138e-2889-4d3b-b9c8-bade656ebc43
md"""
(5) ``{\bf X}``가 이변량 정규분포를 따른다고 가정하자. $\mathbb{V}({\bf X})$의 고유벡터행렬을 활용하는 통계적 처리기법을 있는가? 있다면 서술하라. (하나만 서술해도 무방)
"""

# ╔═╡ 02d60bd7-3c24-4509-b95e-862eacbe1a10
md"""
**<답>**

*  $\mathbb{V}(\bf X)$는 $\bf X$의 공분산 행렬로써 대칭행렬이다. 스펙트럼 정리에 따라 직교행렬인 고유벡터벡터행렬을 찾을 수 있다.
* 이를 해당 이변량 정규분포를 따르는 자료에 대하여 행별로 선형변환을 취해주게 되면, $\bf X$의 각 확률변수가 종속되어 있어도 변수 간 직교하는 데이터를 얻을 수 있게 된다. 이는 데이터가 서로 다른 정보를 가지게 만든다는 점에서 분석에 유용하다.
* 위는 디자인 매트릭스의 각 열들 간 공분산을 계산한 것의 모수적 표현이라고 볼 수 있다. 일반적으로 모수는 알 수 없다는 점에서 실제로는 주성분분석의 직교화에 따른 이점을 활용하는 통계적 처리기법을 대응시킬 수 있다.

---
"""

# ╔═╡ 5232382a-6dd6-42e2-9e9b-92da7dbad672
md"""
(6) SVD를 이용하여 이미지를 압축하는 방법을 간단히 서술하라.
"""

# ╔═╡ 8d60b29f-7567-46f4-bba9-5c5a55008e61
md"""
**<답>**

* 이미지는 행렬로 저장할 수 있으며, 이 행렬에 특이값 분해를 적용하면 특이값이 큰 순서대로 정렬된다. 해당 특이값의 크기는 정보량을 의미하며, 큰 특이값들만을 사용하여 행렬을 재구성하여도 원래 행렬과 유사하게 된다. 즉, 더 적은 숫자만 가지고도 육안으로 볼 때 원본과 차이를 느끼지 못할 정도의 이미지를 만들 수 있다. 이는 이미지가 압축되었음을 의미한다.

---
"""

# ╔═╡ 65e570f3-3597-449c-8e8e-7fe563cef9b9
md"""
(7) 주성분분석을 하게 되면 얻게되는 이점을 간단히 서술하라.
"""

# ╔═╡ 4d239066-b629-4554-b27c-6db11c06869d
md"""
**<답>**

* 주성분분석은 차원축소와 다중공선성 해소의 이점이 있다.
* 주성분분석을 할 때 기존 데이터의 변수들보다 적은 수의 주성분만을 고려하면, 기존의 정보를 거의 유지하면서도 차원을 줄일 수 있다.
* 또한, 기존 데이터 행렬의 설명변수들은 반드시 직교하는 것은 아니다. 하지만 주성분들은 반드시 직교하게 변환되었기 때문에 설명변수 간 상관관계를 깨트릴 수 있다. 이는 다중공선성이 있는 상황에서 데이터를 설명하는 데 유리할 수 있다.

---
"""

# ╔═╡ ac002d2e-1064-433e-b695-01702083b6a4
md"""
(8) 선형변환을 SVD를 이용하여 해석하라.
"""

# ╔═╡ c593fa55-16bd-47f4-a0b5-0c2bdfea88fb
md"""
**<답>**

* 선형변환을 의미하는 행렬을 세 행렬로 특이값분해 할 때, 가운데 행렬을 대각행렬의 형태로 가정하지 않으면 양 옆은 직교행렬의 꼴로 표현할 수 있다.
* 이를 뜯어보면 선형변환은 데이터가 정의되는 축을 재정의한 뒤, 재정의된 축을 방향으로 늘이거나 줄이고, 다시 축을 재정의하여 나타내는 변환으로 해석할 수 있다.

---
"""

# ╔═╡ 1cd6bfe2-a720-46a3-adfe-bebfc23189ef
md"""
(9) 변환을 의미하는 행렬 ${\bf A}$가 데이터를 의미하는 행렬 ${\bf X}$의 앞에 곱해지는 경우와 뒤에 곱해지는 경우 각각 어떠한 의미를 가지는지 설명하라.
"""

# ╔═╡ 0ce0c8ca-0e21-4f05-9f21-902958a1cb4c
md"""
**<답>**

* 변환을 의미하는 행렬이 데이터를 의미하는 행렬 앞에 곱해지는 경우, 열 단위로의 선형변환을 의미하고, 뒤에 곱해지는 경우 행 단위로의 선형변환을 의미한다.
* 데이터를 의미하는 행렬 $\bf X$는 행 별로 관측치를, 열 별로 변수를 나타내는 것이 일반적이다. 따라서 앞에 곱해진 행렬 $\bf A$는 변수 별 표준화를 수행하거나 평균을 계산하는 등의 변환을 수행하고, 뒤에 곱해진 행렬 $\bf A$는 각 관측치들을 이동시키거나 사영하는 등의 변환을 수행한다.

---
"""

# ╔═╡ 816f1e62-3b24-459a-86fb-bfa6624cbe57
md"""
(10) R(*lm()*)과 Python(*sklearn.linear_model*)에서 더미변수가 포함된 회귀분석을 수행하는 로직이 다르다. 차이점에 대하여 서술하라.
"""

# ╔═╡ 82e789aa-c2b7-4a32-9954-263d9e4195d3
md"""
**<답>**

* R에서는 디자인 매트릭스를 변형하지 않고 그대로 이용한다. 더미변수를 포함하면 반드시 한 열이 다른 열들의 선형결합으로 표현되기 때문에 $\bf X^{\top}X$의 역행렬을 구할 수 없다. 따라서 R은 최대열계수를 만들기 위해 더미변수 하나를 임의로 제거하고 회귀분석을 수행한다.
* Python의 `sklearn`은 디자인 매트릭스를 변형하여 회귀분석을 수행한다. 디자인 매트릭스를 열별로 센터링한 뒤, 이것의 특이값분해 표현과 특이값의 역수로 표현된 역행렬을 이용하는 방식이다. 더미변수를 사용하여 계수가 최대가 되지 않아 0인 특이값이 존재한다면, 해당 값은 역수를 취하지 않고 그대로 0으로 표시하여 역행렬과 유사한 형태, 즉, 일반화역행렬을 이용하기 때문에 R과 달리 한 개의 더미변수를 제거할 필요가 없다. 또한 센터링을 진행하기 때문에 이후 계수에 예측값의 차이를 추가적으로 반영한다는 차이점도 있다.

---

"""

# ╔═╡ b16ee528-e081-4f86-b5a6-fbbd3ea0a65e
md"""
*최대한 간단하게 쓰려고 했는데도 꽤 기네요... 한학기동안 감사했습니다...*
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "6e7bcec4be6e95d1f85627422d78f10c0391f199"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─771b13aa-2bdd-400a-87e3-cc5bae383cfe
# ╟─59a4e707-7e30-43ac-8c8c-6103740384c1
# ╠═eb84366e-62e9-445a-9eab-9f7900dc329c
# ╠═e3e0fdec-5d82-4033-a258-1c5ed19f1174
# ╟─3a89c770-a071-4d46-bff3-57e54008f6e8
# ╟─8f8f60db-9082-47a5-8de0-60f11572afcd
# ╟─e3143411-c941-4216-bce2-ed79cd9b318f
# ╟─aa306e3f-6e9a-413c-8e75-22f49fbc150a
# ╟─9bf50bb3-350c-4edd-9a9f-a41c0fc865c2
# ╟─51e8f9e3-b7d4-4e78-8b92-a26af54cda8b
# ╟─6d14b11f-0f77-470a-9512-63fad98dd79a
# ╟─abb7f95d-75c3-4463-88fe-9fb66ae086fe
# ╟─e069c354-8ee3-4490-8937-25a665f0ce54
# ╟─748e2cdf-79ce-43d9-b37b-1427beb4e4ba
# ╟─ad99f90c-512f-450e-89e5-3283b6d68a57
# ╟─b22ca67a-85c7-4de0-992b-3846d185e725
# ╟─734e8d32-55de-4eaf-8498-10c9e9f2e51f
# ╟─b45fd6f2-c06d-4823-9729-856d6dfd225e
# ╟─14c22744-c549-4fac-84e0-7f913f1cfa58
# ╟─ddd0c1bd-19fe-45ab-893b-c94242d612c0
# ╟─52a5dbb8-b2e8-4b67-bac6-8223b48153b5
# ╟─a329cfda-d89c-49e0-9f0e-59d2cad465d5
# ╟─f940af15-906e-4878-80a5-6202ad4ab1f2
# ╟─88d2172a-9df3-454d-ae8b-290a069a6d27
# ╟─a6855040-d2b7-4a94-a91e-9b707f3b6405
# ╟─5d1a6abd-3075-4b7f-95a8-2a4101a81185
# ╟─4820c00c-ddb0-45bf-9cfe-699f1843e440
# ╟─e775138e-2889-4d3b-b9c8-bade656ebc43
# ╟─02d60bd7-3c24-4509-b95e-862eacbe1a10
# ╟─5232382a-6dd6-42e2-9e9b-92da7dbad672
# ╟─8d60b29f-7567-46f4-bba9-5c5a55008e61
# ╟─65e570f3-3597-449c-8e8e-7fe563cef9b9
# ╟─4d239066-b629-4554-b27c-6db11c06869d
# ╟─ac002d2e-1064-433e-b695-01702083b6a4
# ╟─c593fa55-16bd-47f4-a0b5-0c2bdfea88fb
# ╟─1cd6bfe2-a720-46a3-adfe-bebfc23189ef
# ╟─0ce0c8ca-0e21-4f05-9f21-902958a1cb4c
# ╟─816f1e62-3b24-459a-86fb-bfa6624cbe57
# ╟─82e789aa-c2b7-4a32-9954-263d9e4195d3
# ╟─b16ee528-e081-4f86-b5a6-fbbd3ea0a65e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
