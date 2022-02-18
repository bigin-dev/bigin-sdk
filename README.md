Bigin SDK for Google Tag Manager
---

Web Application에서 `이커머스 추적`, `프로필 추적`, `커스텀 이벤트` 등의 데이터를 수집 하는 Bigin SDK의 설치를 지원합니다.<br>
또한 `Bigin SDK Template`을 사용하기 위해서는 `Bigin SDK Loader`가 동일한 GTM 컨테이너에 설치가 되어있어야 하며, Web Application에 이벤트 별 시점에 맞게 DataLayer를 이용해서 이벤트를 호출 하도록 적용이 되어 있어야 합니다.

# 설치 방법

Step1. 정해진 형식에 맞춰 DataLayer 코드를 web application에 추가해 주세요
 - :warning: 정해진 형식에 맞춰 설치를 안할경우 올바른 데이터 수집이 어려우니 반드시 형식에 맞춰 작성해 주세요.

Step2. 태그 생성하기 버튼을 클릭하고 `Bigin SDK` tag를 선택해 주세요.

Step3. 맞춤 이벤트 트리거를 생성해 주세요
- 이벤트 이름의 경우 DataLayer에 명시 되어있는 `biginTracking`을 입력해 주세요

Step4. 생성한 트리거를 선택하고 저장해 주세요

## DataLayer

Bigin SDK Template을 사용하여 SDK를 설치하기 위해서는 DataLayer를 반드시 추가 해야 하며, DataLayer는 각각의 이벤트의 호출시점에 맞춰 동작 되도록 사이트에 설치 해야 합니다.

- DataLayer에 대한 자세한 설명은 [Google Tag Manager : Bigin SDK 설치 가이드 - DataLayer](https://www.notion.so/Google-Tag-Manager-Bigin-SDK-18d1f34824c44fd6bceacfc231ac4f77) 를 참고해 주세요

```javasc
window.dataLayer = window.dataLayer || [];
window.dataLayer.push({
  "event": "biginTracking",
  "bigin": {
    "{{Eevnt_Name}}": {
      "eventType": "{{Event_Type}}",
      "segment": {
				data.....
      }
    }
  }
})
```

> **정해진 형식에 맞춰 설치를 안할경우 올바른 데이터 수집이 어려우니 반드시 형식에 맞춰 작성해 주세요.**

| 속성 | 타입 | 설명                                                                                                                                                                        |
| --- | --- |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| event | string | 맞춤트리거를 생성하여 추적할 이벤트 명이 들어갑니다.                                                                                                                                             |
| {{Eevnt_Name}} | string | 추적할 Bigin 이벤트 명이 들어갑니다.<br>ex) bg:Impression, profile등.. |
|  - eventType | string | 호출하는 이벤트의 유형을 구분하는 아래의 값중 하나가 들어가야 합니다.<br>- **track** : 페이지뷰 등의 별도로 추적이 필요한 기본 이벤트<br>- **user** : 사용자 식별 이벤트<br>- **ecommerce** : 이커머스 추적 이벤트<br>- **custom** : 커스텀 이벤트 |
|  - segment | JSON | 수집할 데이터가 들어갑니다.<br>(올바른 추적을 위하여 커스텀 이벤트를 제외한<br>모든 이벤트는 정해진 속성 키와 값을 맞춰 넣어야 합니다.)                                                                                         |

## 이벤트별 DataLayer 예시코드

### 기본 추적 이벤트

1. 페이지뷰 이벤트
  - 이벤트 명 : `view`
  - 이벤트 타입 : `track`
  - 설치 위치 :  페이지 Router가 변경 되거나 History가 변경되는 곳에 설치 되어야 합니다.

    > [SPA](https://en.wikipedia.org/wiki/Single-page_application) 형식이 아닌 사이트는 별도의 설치가 필요 없지만 만약 `React, Vue`와 같은 언어로 개발된 [SPA](https://en.wikipedia.org/wiki/Single-page_application) 페이지에서는 아래의 스크립트를 모든 페이지에서 동작 되도록 별도의 설치가 필요합니다.

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'view': {
            'eventType': 'track',
            'segment': {
              'previous_view_scroll': 0,
              'pagePathname': '/your/path'
            }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | previous_view_scroll | 필수 | number | 현재 페이지에서 가장 아래로 스크롤 된 세로 길이 (없으면	0) |
    | pagePathname |  | string | 현재 페이지의	pathname |

---

### 사용자 식별 이벤트

1. 프로필 추적 이벤트
  - 이벤트 명 : `profile`
  - 이벤트 타입 : `user`
  - 설치 위치 : 사용자의 정보를 추적하여 식별하기 위해 설치하는 이벤트 이며, 로그인(자동 로그인 포함), 회원가입, 회원 정보 수정 등 회원 정보를 수집할 수 있는 모든 곳에서 호출 되도록 설치 되어야 합니다.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'profile': {
            'eventType': 'user',
            'segment': {
                id: 'biginSDKSample',
                email: 'biginSample@bigin.io',
                name: 'James',
              phoneCell: '010-1111-9999',
              phoneNumber: '02-999-2222',
              nickname: 'Big head',
              emailAgree: true,
              phoneAgree: true,
              gender: 'male',
              birth: '1997.03.29',
              address: '5, Teheran-ro 4-gil, Gangnam-gu, Seoul',
              year: 1997,
              month: 3
            }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | id | 필수 | string | 사용자의 아이디 |
    | email | 필수 | string | 사용자의 이메일 |
    | name | 필수 | string | 사용자의 이름 |
    | phoneCell | 필수 | string | 휴대폰 번호 |
    | phoneNumber |  | string | 집 전화번호 |
    | nickname |  | string | 닉네임 |
    | emailAgree |  | boolean | 마케팅(이메일) 정보 제공 수신 동의 |
    | phoneAgree |  | boolean | 마케팅(문자) 정보 제공 수신 동의 |
    | gender |  | string | 성별(man/woman or 남자/여자) |
    | birth |  | string | 생년월일(YYYY.MM.DD) |
    | address |  | string | 주소 |
    | year |  | number | 생년월일 연도(YYYY) |
    | month |  | number | 생년월일 월(MM) |

2. 로그인
  - 이벤트 명 : `login`
  - 이벤트 타입 : `user`
  - 설치 위치 : 로그인 시점을 특정하기 위한 이벤트로써 로그인 또는 자동 로그인이 이뤄지는 곳에 설치가 되어야 합니다.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'login': {
            'eventType': 'user',
            'segment': {
              type: 'local'
            }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | type | 필수 | string | 로그인 방식<br>- 직접 로그인 : local<br>- 카카오톡 : kakao<br>- 네이버 : naver<br>- 페이스북 : facebook<br>- 애플 : apple<br>- 페이코 : payco |

3. 로그아웃
  - 이벤트 명 : `logout`
  - 이벤트 타입 : `user`
  - 설치 위치 : 로그아웃 시점을 특정하기 위한 이벤트로써 로그아웃이 이뤄지는 곳에 설치 되어야 합니다.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'logout': {
            'eventType': 'user',
            'segment': {}
          }
        }
      });
      ```

---

### 이커머스 추적 이벤트

1. 상품 노출
  - 이벤트 명 : `bg:impression`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 메인 페이지(상품이 노출 될 경우) 또는 상품 리스트 페이지에서 전시된 상품을 클릭 하였을때 또는 클릭 이벤트가 발생하는 곳에 설치 해주세요.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:impression': {
            'eventType': 'ecommerce',
            'segment': {
                 id: 'Spample_0Xx10',
                 name: 'Bigin SDK Sample Product',
                 price: 0,
                 brand: 'biginSDK',
                 category: [
                    'Bigin',
                    'SDK',
                'SampleCode'
                ],
                 thumbnail: [
                    'https://biginSDK.io/sample/code/sample_image_1.jpg',
                    'https://biginSDK.io/sample/code/sample_image_2.jpg',
                    'https://biginSDK.io/sample/code/sample_image_3.jpg'
                ],
              position: 3,
              list: 'https://biginSDK.io/sampleCategory1/list'
             }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | id | 필수 | string | 상품 ID |
    | name | 필수 | string | 상품 이름 |
    | price | 필수 | number | 상품 가격 (판매가 우선) |
    | brand |  | string | 상품 브랜드 |
    | category |  | string[] | 상품 카테고리<br>(순서는 상위 -> 하위 카테고리) |
    | thumbnail |  | string[] | 상품 대표 이미지 URL(scheme 포함) |
    | position |  | number | 상품 목록 중 해당 상품의 게재된 위치 |
    | list |  | string | 상품을 조회한 경로 |

2. 상품 조회
  - 이벤트 명 : `bg:viewProduct`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 상품 상세 페이지 진입(로드)시 호출되도록 설치가 되어야 합니다.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:viewProduct': {
            'eventType': 'ecommerce',
            'segment': {
                 id: 'Spample_0Xx10',
                 name: 'Bigin SDK Sample Product',
                 price: 0,
                 thumbnail: [
                    'https://biginSDK.io/sample/code/sample_image_1.jpg',
                    'https://biginSDK.io/sample/code/sample_image_2.jpg',
                    'https://biginSDK.io/sample/code/sample_image_3.jpg'
                ],
                 brand: 'biginSDK',
                 category: [
                    'Bigin',
                    'SDK',
                'SampleCode'
                ]
             }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | id | 필수 | string | 상품 ID |
    | name | 필수 | string | 상품 이름 |
    | price | 필수 | number | 상품의 판매가 (단위 가격) |
    | thumbnail | 필수 | string[] | 상품 대표 이미지 URL(scheme 포함) |
    | brand |  | string | 상품 브랜드 |
    | category |  | string[] | 상품 카테고리<br>(순서는 상위 --> 하위 카테고리) |

3. 장바구니 추가
  - 이벤트 명 : `bg:addToCart`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 장바구니 버튼 클릭 또는 장바구니 추가 이벤트가 발생하는 곳에 설치 해주세요.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:addToCart': {
            'eventType': 'ecommerce',
            'segment': {
                products: [
                  {
                    id: 'Spample_0Xx10',
                    name: 'Bigin SDK Sample Product',
                    price: 0,
                    quantity: 0,
                    brand: 'biginSDK',
                    category: [
                      'Bigin',
                      'SDK',
                      'SampleCode'
                    ],
                    thumbnail: [
                      'https://biginSDK.io/sample/code/sample_image_1.jpg',
                      'https://biginSDK.io/sample/code/sample_image_2.jpg',
                      'https://biginSDK.io/sample/code/sample_image_3.jpg'
                    ],
                    variant: 'Sample Big, Sample Red, Suboption 1'
                  },
                  {
                      // Data for product 2..
                  }
               ]
            }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | products | 필수 | Object[] | 상품 배열 |
    |    - id | 필수 | string | 상품 ID |
    |    - name | 필수 | string | 상품 이름 |
    |    - price | 필수 | number | 상품 판매가 (단위 가격) |
    |    - quantity |  | number | 상품 수량 |
    |    - brand |  | string | 상품 브랜드 |
    |    - thumbnail |  | string[] | 상품 대표 이미지 URL (scheme 포함) |
    |    - category |  | string[] | 상품 카테고리<br>(순서는 상위 --> 하위 카테고리) |
    |    - variant |  | string | 상품의 옵션<br>(여러 개일 경우 ,로 구분) |

4. 장바구니 조회
  - 이벤트 명 : `bg:cart`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 장바구니 페이지 진입(로드)시 호출되도록 설치가 되어야 합니다.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:cart': {
            'eventType': 'ecommerce',
            'segment': {
                products: [
                  {
                    id: 'Spample_0Xx10',
                    name: 'Bigin SDK Sample Product',
                    price: 0,
                    quantity: 0,
                    brand: 'biginSDK',
                    category: [
                      'Bigin',
                      'SDK',
                      'SampleCode'
                    ],
                    thumbnail: [
                      'https://biginSDK.io/sample/code/sample_image_1.jpg',
                      'https://biginSDK.io/sample/code/sample_image_2.jpg',
                      'https://biginSDK.io/sample/code/sample_image_3.jpg'
                    ],
                    variant: 'Sample Big, Sample Red, Suboption 1'
                  },
                  {
                      // Data for product 2..
                  }
               ]
            }
          },
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명**                              |
    | --- | --- |---------------------------------| --- |
    | products | 필수 | Object[] | 상품 배열                           |
    |    - id | 필수 | string | 상품 ID                           |
    |    - name | 필수 | string | 상품 이름                           |
    |    - price | 필수 | number | 상품 판매가 (단위 가격)                  |
    |    - quantity | 필수 | number | 상품 수량                           |
    |    - brand |  | string | 상품 브랜드                          |
    |    - thumbnail |  | string[] | 상품 대표 이미지 URL (scheme 포함)       |
    |    - category |  | string[] | 상품 카테고리<br>(순서는 상위 --> 하위 카테고리) |
    |    - variant |  | string | 상품의 옵션<br>(여러 개일 경우 ,로 구분)     |

5. 장바구니 삭제
  - 이벤트 명 : `bg:removeCart`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 장바구니에서 삭제 버튼 클릭시 또는 삭제 이벤트가 발생하는 곳에 설치 해주세요.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:removeCart': {
            'eventType': 'ecommerce',
            'segment': {
              products: [
                {
                  id: 'Spample_0Xx10',
                  name: 'Bigin SDK Sample Product',
                  price: 0,
                  quantity: 0,
                  brand: 'biginSDK',
                  category: [
                    'Bigin',
                    'SDK',
                    'SampleCode'
                  ],
                  thumbnail: [
                    'https://biginSDK.io/sample/code/sample_image_1.jpg',
                    'https://biginSDK.io/sample/code/sample_image_2.jpg',
                    'https://biginSDK.io/sample/code/sample_image_3.jpg'
                    ],
                   variant: 'Sample Big, Sample Red, Suboption 1'
                },
                {
                      // Data for product 2..
                }
              ]
            }
          },
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | products | 필수 | Object[] | 상품 배열 |
    |    - id | 필수 | string | 상품 ID |
    |    - name | 필수 | string | 상품 이름 |
    |    - price | 필수 | number | 상품 판매가 (단위 가격) |
    |    - quantity | 필수 | number | 상품 수량 |
    |    - brand |  | string | 상품 브랜드 |
    |    - thumbnail |  | string[] | 상품 대표 이미지 URL (scheme 포함) |
    |    - category |  | string[] | 상품 카테고리<br>(순서는 상위 --> 하위 카테고리) |
    |    - variant |  | string | 상품의 옵션<br>(여러 개일 경우 ,로 구분) |

6. 체크아웃 - Step 0
  - 이벤트 명 : `bg:checkout`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 상품 상세 페이지, 장바구니 페이지에서 구매하기 버튼 클릭 할 때 또는 구매하기 클릭의 이벤트가 발생하는 곳에 설치 해주세요.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:checkout': {
            'eventType': 'ecommerce',
            'segment': {
                step: 0,
                products: [
                  {
                    id: 'Spample_0Xx10',
                    name: 'Bigin SDK Sample Product',
                    price: 0,
                    quantity: 0,
                    brand: 'biginSDK',
                    category: [
                      'Bigin',
                      'SDK',
                      'SampleCode'
                    ],
                     thumbnail: [
                      'https://biginSDK.io/sample/code/sample_image_1.jpg',
                      'https://biginSDK.io/sample/code/sample_image_2.jpg',
                      'https://biginSDK.io/sample/code/sample_image_3.jpg'
                    ],
                    variant: 'Sample Big, Sample Red, Suboption 1'
                  },
                  {
                      // Data for product 2..
                  }
               ]
            }
          },
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | step | 필수 | number | 구매 전 단계<br>- `0` : 주문서 작성 페이지 외의 구매 시도<br>- `1` : 주문서 작성 페이지에서 구매 시도  |
    | products | 필수 | Object[] | 상품 배열 |
    |    - id | 필수 | string | 상품 ID |
    |    - name | 필수 | string | 상품 이름 |
    |    - price | 필수 | number | 상품 판매가 (단위 가격) |
    |    - quantity | 필수 | number | 상품 수량 |
    |    - brand |  | string | 상품 브랜드 |
    |    - thumbnail |  | string[] | 상품 대표 이미지 URL (scheme 포함) |
    |    - category |  | string[] | 상품 카테고리<br>(순서는 상위 --> 하위 카테고리) |
    |    - variant |  | string | 상품의 옵션<br>(여러 개일 경우 ,로 구분) |

7. 체크아웃 - Step 1
  - 이벤트 명 : `bg:checkout`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 주문서 작성(체크아웃) 페이지에서 결제 버튼 클릭시 또는 주문 완료 페이지로 이동되는 이벤트가 발생하는 곳에 설치 해주세요.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:checkout': {
            'eventType': 'ecommerce',
            'segment': {
                step: 0,
                option: '신용카드',
                products: [
                  {
                    id: 'Spample_0Xx10',
                    name: 'Bigin SDK Sample Product',
                    price: 0,
                    quantity: 0,
                    brand: 'biginSDK',
                    category: [
                      'Bigin',
                      'SDK',
                      'SampleCode'
                    ],
                    thumbnail: [
                      'https://biginSDK.io/sample/code/sample_image_1.jpg',
                      'https://biginSDK.io/sample/code/sample_image_2.jpg',
                      'https://biginSDK.io/sample/code/sample_image_3.jpg'
                    ],
                    variant: 'Sample Big, Sample Red, Suboption 1'
                  },
                  {
                      // Data for product 2..
                  }
               ]
            }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | step | 필수 | number | 구매 전 단계<br>- 0 : 주문서 작성 페이지 외의 구매 시도<br>- 1 : 주문서 작성 페이지에서 구매 시도  |
    | option | 필수 | string | 구매시 선택한 결제 방식 |
    | products | 필수 | Object[] | 상품 배열 |
    |    - id | 필수 | string | 상품 ID |
    |    - name | 필수 | string | 상품 이름 |
    |    - price | 필수 | number | 상품 가격 |
    |    - quantity | 필수 | number | 상품 수량 |
    |    - brand |  | string | 상품 브랜드 |
    |    - thumbnail |  | string[] | 상품 대표 이미지 URL (scheme 포함) |
    |    - category |  | string[] | 상품 카테고리<br>(순서는 상위 --> 하위 카테고리) |
    |    - variant |  | string | 상품의 옵션<br>(여러 개일 경우 ,로 구분) |

8. 구매 완료
  - 이벤트 명 : `bg:purchase`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 주문 완료 화면 진입(로드)할 때 호출되도록 설치가 되어야 합니다.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:purchase': {
            'eventType': 'ecommerce',
            'segment': {
              id: 'order_AX00X1_ABCD',
              revenue: 00000,
              shipping: 000,
              tax: 00,
              coupon: '10% sale coupon, 0% coupon',
              products: [
                {
                  id: 'Spample_0Xx10',
                  name: 'Bigin SDK Sample Product',
                  price: 0,
                  quantity: 0,
                  brand: 'biginSDK',
                  category: [
                    'Bigin',
                    'SDK',
                    'SampleCode'
                  ],
                  thumbnail: [
                    'https://biginSDK.io/sample/code/sample_image_1.jpg',
                    'https://biginSDK.io/sample/code/sample_image_2.jpg',
                    'https://biginSDK.io/sample/code/sample_image_3.jpg'
                  ],
                  variant: 'Sample Big, Sample Small, Suboption 1'
                },
                {
                    // Data for product 2..
                }
              ]
            }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | id | 필수 | string | 주문 번호 |
    | revenue | 필수 | number | 총 주문 금액(수익) |
    | shipping |  | number | 배송비 |
    | tax |  | number | 금액에 대한 세금 |
    | coupon |  | string | 사용된 쿠폰의 ID 또는 이름
    (쿠폰이 여러 개일 경우 ,로 구분) |
    | products | 필수 | Object[] | 상품 배열 |
    |    - id | 필수 | string | 상품 ID |
    |    - name | 필수 | string | 상품 이름 |
    |    - price | 필수 | number | 상품 판매가 (단위 가격) |
    |    - quantity | 필수 | number | 상품 수량 |
    |    - brand |  | string | 상품 브랜드 |
    |    - thumbnail |  | string[] | 상품 대표 이미지 URL (scheme 포함) |
    |    - category |  | string[] | 상품 카테고리<br>(순서는 상위 --> 하위 카테고리) |
    |    - variant |  | string | 상품의 옵션<br>(여러 개일 경우 ,로 구분) |

9. 환불
  - 이벤트 명 : `bg:refund`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 환불 신청이 처리되는 위치(스크립트) 또는 환불 신청 완료 페이지에 설치 해주세요.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:refund': {
            'eventType': 'ecommerce',
            'segment': {
                id: 'order_AX00X1_ABCD',
              revenue: 00000,
                products: [
                  {
                    id: 'Spample_0Xx10',
                    name: 'Bigin SDK Sample Product',
                    price: 0,
                    quantity: 0,
                    brand: 'biginSDK',
                    category: [
                      'Bigin',
                      'SDK',
                      'SampleCode'
                    ],
                    thumbnail: [
                       'https://biginSDK.io/sample/code/sample_image_1.jpg',
                       'https://biginSDK.io/sample/code/sample_image_2.jpg',
                       'https://biginSDK.io/sample/code/sample_image_3.jpg'
                    ],
                    variant: 'Sample Big, Sample Small, Suboption 1'
                  },
                  {
                      // Data for product 2..
                  }
               ]
            }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명**                                |
    | --- | --- |-----------------------------------| --- |
    | id | 필수 | number | 주문 번호                             |
    | revenue | 필수 | string | 총 주문 금액(수익)                       |
    | products | 필수 | Object[] | 상품 배열                             |
    |    - id | 필수 | string | 상품 ID                             |
    |    - name | 필수 | string | 상품 이름                             |
    |    - price | 필수 | number | 상품 판매가 (단위 가격)                    |
    |    - quantity | 필수 | number | 상품 수량                             |
    |    - brand |  | string | 상품 브랜드                            |
    |    - thumbnail |  | string[] | 상품 대표 이미지 URL (scheme 포함)         |
    |    - category |  | string[] | 상품 카테고리<br>(순서는 상위 --> 하위 카테고리) |
    |    - variant |  | string | 상품의 옵션<br>(여러 개일 경우 ,로 구분) |

10. 리뷰
  - 이벤트 명 : `bg:review`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 리뷰 등록 버튼 클릭할 때 또는 리뷰 등록 완료 화면에서 호출 되도록 설치 해주세요.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:review': {
            'eventType': 'ecommerce',
            'segment': {
              id: 'Spample_0Xx10_18927',
              product: 'Spample_0Xx10',
              score: 3,
              content: 'best product!!!'
            }
          }
        }
      });
      ```

    | **속성** | **필수여부** | **타입** | **설명**                                                    |
    | --- | --- |-----------------------------------------------------------| --- |
    | id | 필수 | string | 리뷰 ID - {상품 ID}_{리뷰 ID}<br>(리뷰 ID가 없을 때 난수 등을 이용해 생성) |
    | product | 필수 | string | 상품 ID                                                     |
    | score |  | string or number | 리뷰 점수                                                     |
    | content |  | string | 리뷰 내용                                                     |

### 커스텀 이벤트

> 💡 커스텀 이벤트는 기본 추적, 이커머스, 프로필 추적 이벤트와 다른 데이터를 수집하여 추적하고자 할 때 사용되는 이벤트입니다.
> 커스텀 이벤트에는 몇 가지의 사용 규칙이 있습니다, 아래의 사용 규칙을 반드시 지켜 주시기 바랍니다.
>
> **커스텀 이벤트 사용 규칙**
> 1. 속성 키값이 기본 추적, 이커머스, 프로필 추적 이벤트에서 사용하는 키값이면 안됩니다.
> 2. 속성 값에는 배열 데이터는 들어갈 수 없습니다.
>
> ** 아래 내용들은 자주 사용되는 커스텀 이벤트를 활용하여 이해를 돕기위한 예시입니다!! **
> ** 아래 내용을 참고하여 목적에 맞는 커스텀 이벤트를 설치해 주세요.**

1. 네이버페이 - 상품 상세
  - 이벤트 명 : `NpayClick`
  - 이벤트 타입 : `custom`
  - 설치 위치 : 상품 상세 페이지에서 네이버페이 구매 데이터 수집을 위하여 커스텀 이벤트 DataLayer 예시 입니다.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'NpayClick': {
            'eventType': 'custom',
            'segment': {
              NpayProductId: 'Spample_0Xx10',
              NpayProductName: 'Bigin SDK Sample Product',
              NpayProductRevenue: 0,
              NpayProductQuantity: 0,
              NpayProductOption: 'Sample Big, Sample Small, Suboption 1'
            }
          }
        }
      });
      ```

  | **속성키** | **필수여부** | **타입** | **설명**                  |
  | --- | --- | --- |---------------------|
  | NpayProductId | 필수 | string | 상품 아이디              |
  | NpayProductName | 필수 | string | 상품 명                |
  | NpayProductRevenue | 필수 | number | 총 구매 금액<br>(배송비 포함) |
  | NpayProductQuantity | 필수 | number | 총 구매 개수             |
  | NpayProductOption |  | string | 상품 선택된 옵션           |

2. 네이버페이 - 장바구니
  - 이벤트 명 : `NpayClick`
  - 이벤트 타입 : `custom`
  - 설치 위치 : 장바구니 페이지에서 네이버페이 구매 데이터 수집을 위하여 커스텀 이벤트를 설치 할 때의 예시 입니다.

  > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'NpayClick': {
            'eventType': 'custom',
            'segment': {
              NpayProductId: '장바구니',
              NpayProductRevenue: 0
            }
          }
        }
      });
      ```

    | **속성키** | **필수여부** | **타입** | **설명**                  |
    | --- | --- |---------------------| --- |
    | NpayProductId | 필수 | string | 상품 아이디              |
    | NpayProductRevenue | 필수 | number | 총 구매 금액<br>(배송비 포함) |

3. 내부 검색 키워드
  - 이벤트 명 : `InnerSearch`
  - 이벤트 타입 : `custom`
  - 설치 위치 : 내부에서 검색된 키워드 데이터의 수집을 위하여 커스텀 이벤트를 설치 할 때의 예시입니다.

  > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'InnerSearch': {
            'eventType': 'custom',
            'segment': {
              Keyword: 'Bigin Sample Keyword'
            }
          }
        }
      });
      ```

    | **속성키** | **필수여부** | **타입** | **설명** |
    | --- | --- | --- | --- |
    | keyword | 필수 | string | 검색어 |

4. 맴버십
  - 이벤트 명 : `profile`
  - 이벤트 타입 : `user`
    - 설치 위치 : 기존 사용자 프로필 추적 이벤트(`bg:profile`)에 회원 등급을(`membership`) 커스텀 속성으로 하여 추가로 수집하는 방법에 대한 예시 입니다.

    >  **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

        ```javascript
        window.dataLayer = window.dataLayer || [];
        window.dataLayer.push({
          'event': 'biginTracking',
          'bigin': {
            'profile': {
              'eventType': 'user',
              'segment': {
                id: 'biginSDKSample',
                email: 'biginSample@bigin.io',
                name: '김빅인',
                //.... 중간생략
                membership: 'VVIP'
              }
            }
          }
        });
        ```

      | **속성키** | **필수여부** | **타입** | **설명** |
      | --- | --- | --- | --- |
      | membership | 필수 | string | 멤버십 등급 |

5. 사용 쿠폰
  - 이벤트 명 : `bg:purchase`
  - 이벤트 타입 : `ecommerce`
  - 설치 위치 : 아래의 예시는 기존의 상품 구매 이벤트(`bg:purchase`)에 쿠폰에 관련된 커스텀 속성을 추가하여 수집하는 방법에 대한 예시 입니다.

    > **아래 샘플 코드의 스크립트는 예시 코드입니다!! 반드시 사이트에 맞게 설치해주시기 바랍니다.**

      ```javascript
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        'event': 'biginTracking',
        'bigin': {
          'bg:purchase': {
            'eventType': 'user',
            'segment': {
              id: 'biginSDKSample',
              email: 'biginSample@bigin.io',
              name: '김빅인',
              // .... 중간생략
              couponType: '할인',
              couponName: ' Bigin sample coupon - 30,000',
              couponPrice: 30000
            }
          }
        }
      });
      ```

    | **속성키** | **필수여부** | **타입** | **설명**                        |
    | --- | --- |---------------------------| --- |
    | couponType | 필수 | string | 쿠폰 종류 <br>(할인 or 적립 ....) |
    | couponName | 필수 | string | 쿠폰 이름                     |
    | couponPrice | 필수 | number | 쿠폰 가격                     |
