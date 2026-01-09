"use client";

import { ReactNode, useEffect, useState } from "react";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { CandidateAuthProvider, useCandidateAuth } from "@/providers/candidate-auth-provider";

const queryClient = new QueryClient();

// Pages that don't require authentication
const publicPaths = ['/portal/login', '/portal/register', '/portal/forgot-password'];

function PortalLayoutInner({ children }: { children: ReactNode }) {
  const pathname = usePathname();
  const router = useRouter();
  const { candidate, isLoading, isAuthenticated, logout } = useCandidateAuth();
  const [sidebarOpen, setSidebarOpen] = useState(false);

  const isPublicPath = publicPaths.includes(pathname);

  useEffect(() => {
    // Redirect to login if not authenticated and not on public path
    if (!isLoading && !isAuthenticated && !isPublicPath) {
      router.push('/portal/login');
    }
  }, [isLoading, isAuthenticated, isPublicPath, router]);

  // Show loading state
  if (isLoading && !isPublicPath) {
    return (
      <div className="min-h-screen bg-[#0a0f1a] flex items-center justify-center">
        <div className="flex flex-col items-center gap-4">
          <div className="w-12 h-12 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin" />
          <p className="text-gray-400">Loading...</p>
        </div>
      </div>
    );
  }

  // Public pages (login, register) - render without layout
  if (isPublicPath) {
    return <>{children}</>;
  }

  // Protected pages - render with full layout
  if (!isAuthenticated) {
    return null; // Will redirect in useEffect
  }

  const navigation = [
    { name: 'Dashboard', href: '/portal', icon: 'dashboard' },
    { name: 'My Applications', href: '/portal/applications', icon: 'work' },
    { name: 'Profile', href: '/portal/profile', icon: 'person' },
  ];

  return (
    <div className="min-h-screen bg-[#0a0f1a]">
      {/* Mobile sidebar backdrop */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 bg-black/60 z-40 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside
        className={`fixed top-0 left-0 z-50 h-full w-64 bg-[#111827] border-r border-white/10 transform transition-transform duration-200 lg:translate-x-0 ${
          sidebarOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        {/* Logo */}
        <div className="h-16 flex items-center justify-between px-4 border-b border-white/10">
          <Link href="/portal" className="flex items-center gap-3">
            <div className="size-8 text-emerald-400">
              <svg fill="currentColor" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                <path d="M4 42.4379C4 42.4379 14.0962 36.0744 24 41.1692C35.0664 46.8624 44 42.2078 44 42.2078L44 7.01134C44 7.01134 35.068 11.6577 24.0031 5.96913C14.0971 0.876274 4 7.27094 4 7.27094L4 42.4379Z"></path>
              </svg>
            </div>
            <span className="text-lg font-bold text-white">Portal</span>
          </Link>
          <button
            onClick={() => setSidebarOpen(false)}
            className="lg:hidden text-gray-400 hover:text-white"
          >
            <span className="material-symbols-outlined">close</span>
          </button>
        </div>

        {/* Navigation */}
        <nav className="p-4 space-y-1">
          {navigation.map((item) => {
            const isActive = pathname === item.href || 
              (item.href !== '/portal' && pathname.startsWith(item.href));
            
            return (
              <Link
                key={item.name}
                href={item.href}
                onClick={() => setSidebarOpen(false)}
                className={`flex items-center gap-3 px-4 py-3 rounded-lg transition-colors ${
                  isActive
                    ? 'bg-emerald-500/10 text-emerald-400'
                    : 'text-gray-400 hover:bg-white/5 hover:text-white'
                }`}
              >
                <span className="material-symbols-outlined">{item.icon}</span>
                <span className="font-medium">{item.name}</span>
              </Link>
            );
          })}
        </nav>

        {/* User section */}
        <div className="absolute bottom-0 left-0 right-0 p-4 border-t border-white/10">
          <div className="flex items-center gap-3 mb-4">
            <div className="w-10 h-10 rounded-full bg-emerald-500/20 flex items-center justify-center">
              <span className="text-emerald-400 font-bold">
                {candidate?.full_name?.charAt(0) || candidate?.email?.charAt(0) || '?'}
              </span>
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium text-white truncate">
                {candidate?.full_name || 'Candidate'}
              </p>
              <p className="text-xs text-gray-500 truncate">
                {candidate?.email}
              </p>
            </div>
          </div>
          <button
            onClick={logout}
            className="w-full flex items-center justify-center gap-2 px-4 py-2 text-sm text-gray-400 hover:text-white hover:bg-white/5 rounded-lg transition-colors"
          >
            <span className="material-symbols-outlined text-sm">logout</span>
            Sign Out
          </button>
        </div>
      </aside>

      {/* Main content */}
      <div className="lg:pl-64">
        {/* Top bar */}
        <header className="sticky top-0 z-30 h-16 bg-[#0a0f1a]/80 backdrop-blur-md border-b border-white/10">
          <div className="flex items-center justify-between h-full px-4 sm:px-6">
            <button
              onClick={() => setSidebarOpen(true)}
              className="lg:hidden text-gray-400 hover:text-white"
            >
              <span className="material-symbols-outlined">menu</span>
            </button>
            
            <div className="flex-1 lg:flex-none" />
            
            <div className="flex items-center gap-4">
              <Link
                href="/careers"
                className="text-sm text-gray-400 hover:text-white transition-colors flex items-center gap-1"
              >
                <span className="material-symbols-outlined text-sm">open_in_new</span>
                View Jobs
              </Link>
            </div>
          </div>
        </header>

        {/* Page content */}
        <main className="p-4 sm:p-6 lg:p-8">
          {children}
        </main>
      </div>
    </div>
  );
}

export default function PortalLayout({ children }: { children: ReactNode }) {
  return (
    <QueryClientProvider client={queryClient}>
      <CandidateAuthProvider>
        <PortalLayoutInner>{children}</PortalLayoutInner>
      </CandidateAuthProvider>
    </QueryClientProvider>
  );
}

