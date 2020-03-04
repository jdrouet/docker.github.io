const core = require("@actions/core");
const github = require("@actions/github");

const run = () => {
  const message = core.getInput("message");
  const token = core.getInput("token");
  const url = core.getInput("url");

  const octokit = new github.GitHub(token);

  return octokit.checks.create({
    owner: github.context.actor,
    repo: github.context.repo,
    name: message,
    head_sha: github.context.sha,
    conclusion: 'success',
    details_url: url,
    status: 'completed',
  });

};

run().catch(err => {
  core.setFailed(err.message);
});
