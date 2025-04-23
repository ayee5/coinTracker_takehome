include docker

$gcpProjectId = "manifest-alpha-446418-h7"
$imageName   = "helloworld-api"
$imageTag    = "v1.0.0"
$repoName    = "helloworld-api-repo"
$imagePath   = "us-central1-docker.pkg.dev/${gcpProjectId}/${repoName}/${imageName}:${imageTag}"

docker::image { $imagePath:
  ensure => 'present',
}

docker::run { 'helloworld-server':
  ensure  => 'present',
  image   => $imagePath,
  ports   => ['8000:8000'],
  restart => 'always',
}
