// src/components/AnimatedSuccessSVG.js
import React, { useEffect, useRef } from "react";

export function AnimatedSuccessSVG({ onClose }) {
    const svgRef = useRef(null);

    useEffect(() => {
        if (svgRef.current) {
            svgRef.current.classList.add("animate");
        }
    }, []);

    return (
        <div style={overlayStyle}>
            <div style={cardStyle}>
                <style>{`
                    .check-svg { width: 96px; height: 96px; display:block; }
                    .check-circle { stroke: #16a34a; stroke-width: 4; fill: none; 
                        stroke-dasharray: 320; stroke-dashoffset: 320; 
                        transition: stroke-dashoffset 700ms ease-out; }
                    .check-mark { stroke: #16a34a; stroke-width: 4; stroke-linecap: round; 
                        stroke-linejoin: round; fill: none; stroke-dasharray: 48; 
                        stroke-dashoffset: 48; transition: stroke-dashoffset 450ms 350ms ease-out; }
                    .check-svg.animate .check-circle { stroke-dashoffset: 0; }
                    .check-svg.animate .check-mark { stroke-dashoffset: 0; }
                    .success-title { font-size: 18px; font-weight: 700; color: #0f172a; }
                    .success-sub { font-size: 14px; color: #475569; text-align: center; max-width: 340px; }
                    .success-btn { margin-top: 8px; padding: 10px 16px; border-radius: 8px; 
                       background: #1e293b; color: white; border: none; cursor: pointer; 
                       font-weight: 600; }
                `}</style>

                <svg ref={svgRef} className="check-svg" viewBox="0 0 100 100">
                    <circle className="check-circle" cx="50" cy="50" r="46" />
                    <path className="check-mark" d="M30 53 L45 68 L72 36" />
                </svg>

                <div className="success-title">Resume saved successfully</div>

                <div className="success-sub">
                    We processed your CV and created your profile. Continue to your dashboard.
                </div>

                <button className="success-btn" onClick={onClose}>
                    Continue
                </button>
            </div>
        </div>
    );
}

const overlayStyle = {
    position: "fixed",
    top: "0",
    left: "0",
    width: "100vw",
    height: "100vh",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    background: "rgba(10, 11, 13, 0.45)",
    zIndex: "9999"
};

const cardStyle = {
    background: "#ffffff",
    padding: "28px",
    borderRadius: "12px",
    boxShadow: "0 10px 30px rgba(2,6,23,0.2)",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    gap: "12px",
    minWidth: "320px"
};
