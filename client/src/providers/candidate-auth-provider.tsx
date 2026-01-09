"use client";

import { createContext, useContext, ReactNode, useEffect, useState } from 'react';
import { useCandidateProfile } from '@/features/candidate/hooks/use-candidate-auth';
import type { Candidate } from '@/features/candidate/types';

interface CandidateAuthContextType {
  candidate: Candidate | null | undefined;
  isLoading: boolean;
  isAuthenticated: boolean;
  error: Error | null;
  logout: () => void;
}

const CandidateAuthContext = createContext<CandidateAuthContextType | undefined>(undefined);

export function CandidateAuthProvider({ children }: { children: ReactNode }) {
  const [hasToken, setHasToken] = useState(false);
  const { data: candidate, isLoading, error } = useCandidateProfile();

  useEffect(() => {
    // Check for token on mount
    if (typeof window !== 'undefined') {
      const token = localStorage.getItem('candidate_token');
      setHasToken(!!token);
    }
  }, []);

  const logout = () => {
    if (typeof window !== 'undefined') {
      localStorage.removeItem('candidate_token');
      setHasToken(false);
      window.location.href = '/portal/login';
    }
  };

  const isAuthenticated = hasToken && !!candidate;

  return (
    <CandidateAuthContext.Provider
      value={{
        candidate: candidate || null,
        isLoading,
        isAuthenticated,
        error: error as Error | null,
        logout,
      }}
    >
      {children}
    </CandidateAuthContext.Provider>
  );
}

export function useCandidateAuth() {
  const context = useContext(CandidateAuthContext);
  if (context === undefined) {
    throw new Error('useCandidateAuth must be used within a CandidateAuthProvider');
  }
  return context;
}

