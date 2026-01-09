"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { motion } from "motion/react";
import { useCandidateLogin } from "@/features/candidate/hooks/use-candidate-auth";

export default function CandidateLoginPage() {
  const router = useRouter();
  const loginMutation = useCandidateLogin();
  
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    
    try {
      await loginMutation.mutateAsync({ email, password });
      router.push("/portal");
    } catch (err: any) {
      setError(err.response?.data?.detail || "Invalid email or password");
    }
  };

  return (
    <div className="min-h-screen flex flex-col bg-[#0a0f1a]">
      {/* Header */}
      <header className="w-full border-b border-white/10 bg-[#0a0f1a]/80 backdrop-blur-md">
        <div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8">
          <Link href="/careers" className="flex items-center gap-3">
            <div className="size-8 text-emerald-400">
              <svg fill="currentColor" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                <path d="M4 42.4379C4 42.4379 14.0962 36.0744 24 41.1692C35.0664 46.8624 44 42.2078 44 42.2078L44 7.01134C44 7.01134 35.068 11.6577 24.0031 5.96913C14.0971 0.876274 4 7.27094 4 7.27094L4 42.4379Z"></path>
              </svg>
            </div>
            <span className="text-xl font-bold text-white tracking-tight">Candidate Portal</span>
          </Link>
          <Link
            href="/careers"
            className="text-sm text-gray-400 hover:text-white transition-colors"
          >
            ← Back to Careers
          </Link>
        </div>
      </header>

      {/* Main */}
      <main className="flex-1 flex items-center justify-center p-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
          className="w-full max-w-md"
        >
          {/* Card */}
          <div className="bg-[#111827] border border-white/10 rounded-2xl p-8 shadow-2xl">
            <div className="text-center mb-8">
              <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-emerald-500/10 mb-4">
                <span className="material-symbols-outlined text-3xl text-emerald-400">
                  person
                </span>
              </div>
              <h1 className="text-2xl font-bold text-white">Welcome Back</h1>
              <p className="text-gray-400 mt-2">
                Sign in to track your applications
              </p>
            </div>

            {error && (
              <motion.div
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                className="mb-6 p-4 bg-red-500/10 border border-red-500/20 rounded-lg"
              >
                <p className="text-sm text-red-400 flex items-center gap-2">
                  <span className="material-symbols-outlined text-sm">error</span>
                  {error}
                </p>
              </motion.div>
            )}

            <form onSubmit={handleSubmit} className="space-y-5">
              <div>
                <label className="block text-sm font-medium text-gray-300 mb-2">
                  Email Address
                </label>
                <div className="relative">
                  <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-500">
                    mail
                  </span>
                  <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="you@example.com"
                    required
                    className="w-full pl-10 pr-4 py-3 bg-[#1a2234] border border-white/10 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 transition-all"
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-300 mb-2">
                  Password
                </label>
                <div className="relative">
                  <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-500">
                    lock
                  </span>
                  <input
                    type={showPassword ? "text" : "password"}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Enter your password"
                    required
                    className="w-full pl-10 pr-12 py-3 bg-[#1a2234] border border-white/10 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 transition-all"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-300"
                  >
                    <span className="material-symbols-outlined">
                      {showPassword ? "visibility_off" : "visibility"}
                    </span>
                  </button>
                </div>
              </div>

              <div className="flex items-center justify-between">
                <label className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    className="w-4 h-4 rounded border-gray-600 bg-[#1a2234] text-emerald-500 focus:ring-emerald-500"
                  />
                  <span className="text-sm text-gray-400">Remember me</span>
                </label>
                <Link
                  href="/portal/forgot-password"
                  className="text-sm text-emerald-400 hover:text-emerald-300 transition-colors"
                >
                  Forgot password?
                </Link>
              </div>

              <button
                type="submit"
                disabled={loginMutation.isPending}
                className="w-full py-3 px-4 bg-gradient-to-r from-emerald-500 to-teal-500 text-white font-bold rounded-lg shadow-lg shadow-emerald-500/25 hover:shadow-emerald-500/40 disabled:opacity-50 disabled:cursor-not-allowed transition-all flex items-center justify-center gap-2"
              >
                {loginMutation.isPending ? (
                  <>
                    <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                    Signing in...
                  </>
                ) : (
                  <>
                    Sign In
                    <span className="material-symbols-outlined">arrow_forward</span>
                  </>
                )}
              </button>
            </form>

            <div className="mt-8 pt-6 border-t border-white/10 text-center">
              <p className="text-gray-400">
                Don&apos;t have an account?{" "}
                <Link
                  href="/portal/register"
                  className="text-emerald-400 hover:text-emerald-300 font-medium transition-colors"
                >
                  Create one
                </Link>
              </p>
            </div>
          </div>

          {/* Footer note */}
          <p className="text-center text-gray-500 text-sm mt-6">
            By signing in, you agree to our{" "}
            <Link href="#" className="text-gray-400 hover:text-white underline">
              Terms of Service
            </Link>{" "}
            and{" "}
            <Link href="#" className="text-gray-400 hover:text-white underline">
              Privacy Policy
            </Link>
          </p>
        </motion.div>
      </main>
    </div>
  );
}

