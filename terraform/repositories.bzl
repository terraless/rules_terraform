load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

_terraform_releases = {
    "0.11.13": [
        {
            "os": "linux",
            "arch": "amd64",
            "sha256": "5925cd4d81e7d8f42a0054df2aafd66e2ab7408dbed2bd748f0022cfe592f8d2",
        },
        {
            "os": "darwin",
            "arch": "amd64",
            "sha256": "e9988443da39e5d81a5f7f1b6a5d97b25e2a1151d9be76cdc2e380df97e57856",
        },
    ],
}

def terraform_tools():
    for version, platforms in _terraform_releases.items():
        for platform in platforms:
            http_archive(
                name = "terraform_{os}_{arch}".format(**platform),
                build_file_content = """exports_files(["terraform"], visibility = ["//visibility:public"])""",
                url = "https://releases.hashicorp.com/terraform/{version}/terraform_{version}_{os}_{arch}.zip".format(
                    version = version,
                    **platform
                ),
                sha256 = platform["sha256"],
            )
