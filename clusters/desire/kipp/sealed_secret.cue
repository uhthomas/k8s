package kipp

sealed_secret: {
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	metadata: name: "kipp"
	spec: {
		encryptedData: {
			"aws-config": "AgAtBuQunn0DqdhHNO6CBhJulvVH26gt37rvqrlTH/POBZie/Bb1fLUiaSTTbR81xVj8ydrYfMwFk23BY6Gz39z4P7nJLzlf7FQmbs7BLkXHdMFKGU7g0mBbGzoKEsLQ1sKVN2y1UrnPtr93mhCj6swEknUMCr1diTVZWasRsYJ9bBUVfI7fbf4sbKjnaL3QC3k4J9Qhcq/rAtPqldU8HIoNtLHokp0Myt5QUlIi/9kZImXx6C2m2L1rT8Kx2BUL6FUWn6n4VF/c2LYr4kFGw6GZ7aqsMwuXCtaIt/7/H900WlRrRambfRrS8DourMOMMjs7XvVKw+aU30Ypm3Ql/hQWuWnj7jAIpkVW6CAmJ5OtKCDLfh8BEnh1+L50sWr//BCzmQJBsIIzafO5Wg2k+k1dLx27giVF+9IYmuzM0RXApDpnd8cWpI9+SdDcZuAFgCpBhit5oxxCtCSoV1A77w7gW1lQzcH+Bsjy5A6DHo4hNUu/BXjkBIJ+9rnww56jQ36ytDKAdmd0CDtxsSK+R8TooEnB6vDBiWnSb0YOHl4Cqro+px0Bvhl0ojNoMiu3CPJhHp9WXMZQ8gOFKxUx64iSIbReryKx0RPYZUAfuyw3FCdq2+0Uvzzw4NaFYSjMifb/vqtG29RMgcenO9VRwtZAt3dTT4cT/F6m0gc7ICJezqk/s0oM4K782cq6dM4CkCEyEjz0UwBAiWxMiHFr26jQJgzkaV1VRlhXguW14JRlCR3T4Y1wH/ccgkjZvWnH9Pp0fpzvpqQUqEHbQdQWwKZSszTbcJVV9C+aJZRmjP75IQ1syZVbkjw1ySQcH7YtxJmXSXZFT4XZRd8P85kIgqLn"
			database:     "AgAbPE58gcw9vwnKQDDGDRMYtXuA7asNUM3aMxoyA0qNwxIs6C59oAWLxdhDR0phUue5B60TbdmJs6XBQMn7h3F0bAOTc2x2u5O0rVj8IPvnxusDqzNNzdXb0OuPJjvfs1cra/q/ABcxmv4GLrMlg+CmvAwASZfsJ6pu8hETZTc1/G0sC5Dt3+YiQrFSpEIRsS/hHtDOlA6CJVKIDaP59dnyK+csJaeEZb99YcicbVCvLLPsvSZjGtB8rHZZODxGdniQtBhDt8AN1Qx9YlUUS5pE0CGSA0VbixclDHEmOnyuFn47f/SidkpCOPnSP6mj8+CphIZJ3JbXVaiAawM9cqCYm3Nnjw2Hbhp602VsKgDfCckz8TgNJKzL6CUE0Xg9TEWdAgSNC5vZjiIkhUT7Lcjnh3DVK6YOlmYE7CCTi9/Bp5SnKAlVB93Z8m00UPSi4NNreu/49Mrmvgr2SJ/pm8XrQIr35ZZH9AwR0uw6HOO1vC4A4uzlOkOKk0e1nq1v7JULOMHr6XH2xuRC/4lAEZLkyHajSdx70KvJP4kPfqQ096KHiPRpKXjoIwniN9SDHHBhbo1+Z7bu7VS1c4xZx0alWFxM9wPAw/2LEcIw7msDxhtckBvpaIdjYfU8nZoTxTnaWP9bThW00d3lngB6BAW6uWHyRRN+c+tiGUg+ViDK9TnGGU6wzNQA5rSuyfRIFFDnWy18SXHcd1B+Qg2fgp3b7KE46GXMqSBVe7sZFUgtrCJEPGodmXbjDGTYanndTmqnZOM27cvQ2FjkNgbm029OAgozsqU6jkpx278="
		}
		template: metadata: {
			name:      "kipp"
			namespace: "kipp"
		}
	}
}
