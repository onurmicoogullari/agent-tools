const kubeconfig = `${process.env.HOME}/.kube/agent-config`
const initializedSessions = new Set()

export default async () => ({
  "shell.env": async (input, output) => {
    if (input.sessionID) {
      if (initializedSessions.has(input.sessionID)) return
      initializedSessions.add(input.sessionID)
    }

    output.env.KUBECONFIG = kubeconfig
  },
})
