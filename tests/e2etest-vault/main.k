import models.io.crossplane.apiextensions.v1 as apiextensions

e2etest = apiextensions.E2ETest {
    metadata.name = "e2etest-vault"
    spec = {
        compositionPath = "../../apis/vaults/composition.yaml"
        xrdPath = "../../apis/vaults/definition.yaml"
        timeoutSeconds = 300
        skipDelete = False
        claimPath = "claim.yaml"
    }
}
