type Request = (
  input: string,
) => Promise<{ ok: boolean; json(): Promise<unknown> }>;

export async function checkHealth(
  request: Request = (input) =>
    fetch(input, { signal: AbortSignal.timeout(5000) }),
): Promise<boolean> {
  try {
    const response = await request("/actuator/health");
    if (!response.ok) return false;
    const health = await response.json();
    return (
      typeof health === "object" &&
      health !== null &&
      "status" in health &&
      health.status === "UP"
    );
  } catch {
    return false;
  }
}
