import { describe, expect, it, vi } from "vitest";
import { checkHealth } from "./health";

describe("hosting health indicator", () => {
  it("shows available only for a healthy server", async () => {
    const request = vi
      .fn()
      .mockResolvedValue({ ok: true, json: async () => ({ status: "UP" }) });
    expect(await checkHealth(request)).toBe(true);
  });
  it("handles an unreachable server without throwing", async () => {
    const request = vi.fn().mockRejectedValue(new Error("offline"));
    expect(await checkHealth(request)).toBe(false);
  });
});
